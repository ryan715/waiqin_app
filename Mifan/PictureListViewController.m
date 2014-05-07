//
//  PictureListViewController.m
//  Mifan
//
//  Created by ryan on 14-4-2.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "PictureListViewController.h"
#import "SWRevealViewController.h"
#import "PictureNewViewController.h"
#import "PicturesCell.h"
#import <CommonCrypto/CommonDigest.h>
#import "User.h"
#import "Hint.h"


@interface PictureListViewController ()
{
    UIImage *photoImage;
    NSMutableArray *itemList;
    
    NSMutableArray *moreArray;
    User *user;
    Hint *h;
    
    int dataNumber;
    BOOL _loadingMore;
    int pageNumber;
}
@end

@implementation PictureListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    itemList = [[NSMutableArray alloc] init];
    moreArray = [[NSMutableArray alloc] init];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    pageNumber = 1;
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadData];
    self.title = @"图文上报";
    
    h = [[Hint alloc]initWithNibName:@"Hint" bundle:nil];
    
    [self customRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return itemList.count;
}

- (void)loadData
{
    _wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"mango" accessGroup:nil];
    NSString *userName = [_wrapper objectForKey:(__bridge id)kSecAttrAccount];
    NSString *userPassword = [_wrapper objectForKey:(__bridge id)kSecValueData];
    
    _client = [WaiqinHttpClient sharedWaiqinHttpClient];
    const char *cStr = [userPassword UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    userPassword = [NSString stringWithFormat:
                    @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                    result[0], result[1], result[2], result[3],
                    result[4], result[5], result[6], result[7],
                    result[8], result[9], result[10], result[11],
                    result[12], result[13], result[14], result[15]
                    ];
    
    _client.delegate = self;
    [_client loginActionUser:userName withPassword:userPassword];

    
}



- (void)waiqinHTTPClient:(WaiqinHttpClient *)client didSignin:(id)responseData
{
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    id statusID = [res objectForKey:@"status"];
    NSString *status = @"";
    
    if (statusID != [NSNull null]) {
        status = statusID;
    if ([status isEqualToString:@"1"]) {
        NSDictionary *dictionaryList;
        NSArray *arrayList = [res objectForKey:@"lists"];
        dictionaryList = [arrayList objectAtIndex: 0];
        user = [[User alloc] initWithImage:@"" name: [dictionaryList objectForKey:@"username"] pwd:[dictionaryList objectForKey:@"password"] group:[dictionaryList objectForKey:@"unitname"] idString:[dictionaryList objectForKey:@"id"]];
        
        [self getData:@"1" httpClient:client];
        pageNumber = 1;
        }
    }
}

/* 获取服务端shuju */
- (void)getData: (NSString *)stringPage httpClient:(WaiqinHttpClient *)httpClient
{
    [httpClient listImage:user.idString withPageIndex:stringPage withPageSize:@"15"];
    
//    NSLog(@"refesh");

}

- (void)waiqinHTTPClient:(WaiqinHttpClient *)client listImageDelegate:(id)responseData
{
//    NSLog(@"the response data is %@",[responseData objectForKey:@"wsr"]);

//   清空数据
//    itemList = nil;
    
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    NSString *status = [res objectForKey:@"status"];
    
    if ([status isEqualToString:@"1"]) {
                NSDictionary *dictionaryList;
        
        id idCount = [responseData objectForKey:@"count"];
        NSString *strCount = @"";
        
        if (idCount != [NSNull null]) {
            strCount = idCount;
            
            if (![strCount isEqualToString:@"0"]) {
                
                dataNumber = [strCount intValue];
                
                NSArray *arrayList = [res objectForKey:@"lists"];
                [moreArray removeAllObjects];
                //        NSLog(@"the array list is %d", arrayList.count);
                for (int i= 0; i< arrayList.count; i++) {
                    dictionaryList = [arrayList objectAtIndex:i];
                    NSString *urlString = [NSString stringWithFormat:@"http://72.14.191.249:8080/ExpertSelectSystemV1.1%@", [dictionaryList objectForKey:@"imgstr"]];
                    Picture *model = [[Picture alloc] initWithName: [dictionaryList objectForKey:@"username"] Title:[dictionaryList objectForKey:@"beizhu"] Picture:urlString];
                    
                    [moreArray addObject:model];
                    //            NSLog(@"the pic list is %d", itemList.count);
                    
                }
                
                for (int j=0; j<[moreArray count]; j++) {
                    [itemList addObject:[moreArray objectAtIndex:j]];
                }
                [self.tableView reloadData];
                [self createTableFooter];

            } else {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"芒果外勤"
                                                             message:@"当前无数据"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av show];
            }
        }

        
    } else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"芒果外勤"
                                                     message:@"加载失败"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    static NSString *pictureCell = @"PictureCellIdentifier";
    static BOOL isRegNib = NO;
    if (!isRegNib) {
        [self.tableView registerNib:[UINib nibWithNibName:@"PicturesCell" bundle:nil ] forCellReuseIdentifier:pictureCell];
        isRegNib = YES;
    }
    PicturesCell *cell = [self.tableView dequeueReusableCellWithIdentifier:pictureCell];
    [cell setupCell: itemList[indexPath.row]];
    
    cell.pictureImageView.canClick = YES;
    [cell.pictureImageView setClickToViewController];
    
    
//    cell.titleLabel.font = [UIFont systemFontOfSize: 13];
//    cell.titleLabel.text = ((Picture *)itemList[indexPath.row]).titleString;
//    cell.titleLabel.numberOfLines = 0 ;
    CGSize requiredSize = [ ((Picture *)itemList[indexPath.row]).titleString sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize: CGSizeMake(200, 10000) lineBreakMode:NSLineBreakByWordWrapping];
//    cell.titleLabel.frame = CGRectMake(113, 48, requiredSize.width, requiredSize.height);
//    NSLog(@"the titlelabel hight is %f", requiredSize.height);
    if (requiredSize.height > 53.0f ) {
        float realHeight = requiredSize.height - 53.0f;
        CGRect rect = cell.frame;
        rect.size.height = cell.frame.size.height + realHeight;
        cell.frame = rect;
    }
    
    if (cell == nil) {
        [self.tableView registerNib:[UINib nibWithNibName:@"PicturesCell" bundle:nil] forCellReuseIdentifier:pictureCell];
        PicturesCell *cell1 = [self.tableView dequeueReusableCellWithIdentifier:pictureCell];
        [cell1 setupCell:itemList[indexPath.row]];
        
        cell1.pictureImageView.canClick = YES;
        [cell1.pictureImageView setClickToViewController];
        
//        cell1.titleLabel.font = [UIFont systemFontOfSize: 13];
//        cell1.titleLabel.text = ((Picture *)itemList[indexPath.row]).titleString;
//        cell1.titleLabel.numberOfLines = 0 ;
        CGSize requiredSize = [ ((Picture *)itemList[indexPath.row]).titleString sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize: CGSizeMake(200, 10000) lineBreakMode:NSLineBreakByWordWrapping];
//        cell1.titleLabel.frame = CGRectMake(113, 48, requiredSize.width, requiredSize.height);
        if (requiredSize.height > 53.0f ) {
            float realHeight = requiredSize.height - 53.0f;
            
            CGRect rect = cell1.frame;
            rect.size.height = cell.frame.size.height + realHeight;
            cell1.frame = rect;
            
        }

        
        cell = cell1;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    // 1.封装图片数据
//    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: 1];
////    for (int i = 0; i < [myImageUrlArr count]; i++) {
//        // 替换为中等尺寸图片
//    Picture *picModel = itemList[indexPath.row];
//    
//        NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", picModel.pictureString];
//        MJPhoto *photo = [[MJPhoto alloc] init];
//        photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
//        
//    UIImageView * imageView; //(UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
//        photo.srcImageView = imageView;
//        [photos addObject:photo];
////    }
//    
//    // 2.显示相册
//    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
////    browser.currentPhotoIndex = (imageTap.view.tag - 10000); // 弹出相册时显示的第一张图片是？
//    browser.photos = photos; // 设置所有的图片
//    [browser show];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    PicturesCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    if(cell.frame.size.height > 120){
//        return cell.frame.size.height;
//    } else {
//        return 120.0f;
//    }
//    
//    NSLog(@"the cell is %d",indexPath.row);
//    NSLog(@"the high is %d", cell.frame.size.height);

    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
//    NSLog(@"the cell is %d",indexPath.row);
//    NSLog(@"the high is %d", cell.frame.size.height);
    
    
    return cell.frame.size.height;
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"toPictureNew"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        PictureNewViewController *picNew = [[navigationController viewControllers] objectAtIndex:0];
        
        picNew.photoImage = photoImage;
        picNew.userModel = user;
        picNew.delegate = self;
    }
}


- (IBAction)photoAction:(id)sender
{
    [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil]
     showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id)self;
    
    switch (buttonIndex) {
        case 0:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }else{
                NSLog(@"模拟器无法打开相机");
            }
            [self presentModalViewController:picker animated:YES];
            break;
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentModalViewController:picker animated:YES];
        default:
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    photoImage = [self scaleImage:originImage toScale:0.3];
    [picker dismissModalViewControllerAnimated:NO];
    
    [self performSegueWithIdentifier:@"toPictureNew" sender:self];
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSzie
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSzie, image.size.height *scaleSzie));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSzie, image.size.height * scaleSzie)];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
    
}

- (void)toNewList:(PictureNewViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self loadData];
}

- (void) createTableFooter
{
    self.tableView.tableFooterView = nil;
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 40.0f)];
    
    UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 116.0f, 40.0f)];
    [loadMoreText setCenter:tableFooterView.center];
    [loadMoreText setFont: [UIFont fontWithName:@"Helvetica Neue" size:14]];
    [loadMoreText setText: @"上拉显示更多"];
    [tableFooterView addSubview:loadMoreText];
    self.tableView.tableFooterView = tableFooterView;
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!_loadingMore && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height))) {
        [self loadDataBegin];
    }
}

- (void)loadDataBegin
{
    if (_loadingMore == NO) {
        _loadingMore = YES;
        UIActivityIndicatorView *tableFooterActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(75.0f, 10.0f, 20.0f, 20.0f)];
        [tableFooterActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [tableFooterActivityIndicator startAnimating];
        [self.tableView.tableFooterView addSubview:tableFooterActivityIndicator];
        
//        [tableFooterActivityIndicator stopAnimating];
        [self loadDataing];
    }
}

- (void)loadDataing
{
    int pageInt = dataNumber / 15;
    
    
    if (pageNumber < pageInt) {
        pageNumber ++;
        
        NSString *pageString = [NSString stringWithFormat:@"%d", pageNumber];
        [self getData:pageString httpClient:_client];
        [self loadDataEnd];

    } else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"芒果外勤"
                                                     message:@"当前无数据"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
        
        [self createTableFooter];

    }
   }


- (void)loadDataEnd
{
    _loadingMore = NO;
    [self createTableFooter];
}


/**************   下拉刷新 ********/

- (void)customRefresh
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    //refreshControl.tintColor = [UIColor magentaColor];
    [refreshControl addTarget:self action:@selector(RefreshTable) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)RefreshTable
{
    [itemList removeAllObjects];
//    NSLog(@"refresh table");
//    if ([_client isEqual:[NSNull null]]) {
        _client = [WaiqinHttpClient sharedWaiqinHttpClient];
//        NSLog(@"the client is null");
//    }
//    [self getData:@"1" httpClient:_client];
    
    [self loadData];
    [self performSelector:@selector(updateTable) withObject:nil afterDelay:1];
}

- (void)updateTable
{
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

/**************   下拉刷新 ********/


@end
