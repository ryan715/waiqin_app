//
//  AboutViewController.m
//  Mifan
//
//  Created by ryan on 13-12-9.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "AboutViewController.h"
#import "SWRevealViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "User.h"
#import "ImageHelper.h"

@interface AboutViewController ()
{
    User *user;
}
@end

@implementation AboutViewController

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
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    [self getUserAction];
    
    self.view.backgroundColor = [UIColor colorWithRed:(float)(239/255.0) green:(float)(239/255.0) blue:(float)(244/255.0) alpha:1.0];
    self.tableView.backgroundColor = [UIColor colorWithRed:(float)(239/255.0) green:(float)(239/255.0) blue:(float)(244/255.0) alpha:1.0];
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableViewCellIdentifier = @"AboutCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
    }
    if (indexPath.row == 0) {
        NSLog(@"test");
//        [cell.contentView addSubview:[self customUser:@""]];
        cell.textLabel.text = @" yxr.306789@163.com";
        
        UIImage *imageZhifubao = [UIImage imageNamed:@"zhifubao.png"];
        [cell.imageView setImage:imageZhifubao];
    } else if(indexPath.row == 1){
        cell.textLabel.text = @"         2650974866";
        UIImage *imageQq = [UIImage imageNamed:@"qq.png"];
        [cell.imageView setImage:imageQq];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14.0];
    return cell;
}


- (void)getUserAction
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
    NSString *status = [res objectForKey:@"status"];
    if ([status isEqualToString:@"1"]) {
        NSDictionary *dictionaryList;
        NSArray *arrayList = [res objectForKey:@"lists"];
        dictionaryList = [arrayList objectAtIndex: 0];
        user = [[User alloc] initWithImage:@"" name: [dictionaryList objectForKey:@"username"] pwd:[dictionaryList objectForKey:@"password"] group:[dictionaryList objectForKey:@"unitname"] idString:[dictionaryList objectForKey:@"id"]];
        
//        [self customUser:@""];
        
    }
}

- (UIImageView *)customUser: (NSString *)imageURLString
{
    UIImage *profileImage = [UIImage imageNamed:@"tx1.jpg"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    ImageHelper *imageHelper = [[ImageHelper alloc] init];
    imageView.image  = [imageHelper ellipseImage:profileImage withInset:0.0];
    return imageView;
    //[self.view addSubview:imageView];
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView;
    UILabel *footLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    footLabel.text = @"技术支持:芒果科技";
    footLabel.textColor = [UIColor colorWithRed:(float)(109/255.0) green:(float)(109/255.0) blue:(float)(114/255.0) alpha:1.0];
                           
    footLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:12.0];
    
    footLabel.backgroundColor = [UIColor clearColor];
    footLabel.textAlignment = UITextAlignmentCenter;
//    [footLabel sizeToFit];
    footLabel.frame = CGRectMake(0.0, 0.0, 320, 30);
    
    
    CGRect footViewFrame = CGRectMake(0.0f, 0.0f, 320.0, 40.0);
    footView = [[UIView alloc] initWithFrame:footViewFrame];
    [footView addSubview:footLabel];
    
    return footView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://shenghuo.alipay.com/transfer/ac/acFill.htm"]];
    }
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
