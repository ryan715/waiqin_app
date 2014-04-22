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
    User *user;
    Hint *h;
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
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadData];
    self.title = @"图文上报";
    
    h = [[Hint alloc]initWithNibName:@"Hint" bundle:nil];
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
        
        [client listImage:user.idString withPageIndex:@"1" withPageSize:@"15"];
    }
    }
}

- (void)waiqinHTTPClient:(WaiqinHttpClient *)client listImageDelegate:(id)responseData
{
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    NSString *status = [res objectForKey:@"status"];
    
    if ([status isEqualToString:@"1"]) {
                NSDictionary *dictionaryList;
        NSArray *arrayList = [res objectForKey:@"lists"];
        
        NSLog(@"the array list is %d", arrayList.count);
        for (int i= 0; i< arrayList.count; i++) {
            dictionaryList = [arrayList objectAtIndex:i];
            NSString *urlString = [NSString stringWithFormat:@"http://72.14.191.249:8080/ExpertSelectSystemV1.1%@", [dictionaryList objectForKey:@"imgstr"]];
            Picture *model = [[Picture alloc] initWithName:@"a005" Title:[dictionaryList objectForKey:@"beizhu"] Picture:urlString];
            
            [itemList addObject:model];
            NSLog(@"the pic list is %d", itemList.count);

        }
        [self.tableView reloadData];
    } else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"芒果外勤"
                                                     message:@"加载失败"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
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
    
    
    if (cell == nil) {
        [self.tableView registerNib:[UINib nibWithNibName:@"PicturesCell" bundle:nil] forCellReuseIdentifier:pictureCell];
        PicturesCell *cell1 = [self.tableView dequeueReusableCellWithIdentifier:pictureCell];
        [cell1 setupCell:itemList[indexPath.row]];
        
        cell1.pictureImageView.canClick = YES;
        [cell1.pictureImageView setClickToViewController];
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
}

@end
