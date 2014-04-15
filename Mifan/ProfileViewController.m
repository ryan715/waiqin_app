//
//  ProfileViewController.m
//  Mifan
//
//  Created by ryan on 14-4-7.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "User.h"
#import "ImageHelper.h"
#import "UIImage+Blur.h"

@interface ProfileViewController ()
{
    User *user;
}
@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.title = @"我";
    
    [self getUserAction];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        [self customUser:@""];
        
    }
}

- (void)customUser: (NSString *)imageURLString
{
    UIImage *profileImage = [UIImage imageNamed:@"tx1.jpg"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    ImageHelper *imageHelper = [[ImageHelper alloc] init];
    imageView.image  = [imageHelper ellipseImage:profileImage withInset:0.0];
//    return imageView;
    imageView.contentMode = UIViewContentModeCenter;
    imageView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2-100);
    
    UIImage *profileBackgroundImage = [UIImage imageNamed:@"tx1.jpg"];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 300)];
//    ImageHelper *imageHelper = [[ImageHelper alloc] init];
//    imageView.image  = [imageHelper ellipseImage:profileImage withInset:0.0];
//    //    return imageView;
//    
    
    // jpeg quality image data
    float quality = .00001f;
    // intensity of blurred
    float blurred = .5f;
    NSData *imageData = UIImageJPEGRepresentation(profileBackgroundImage, quality);
    UIImage *blurredImage = [[UIImage imageWithData:imageData] blurredImage:blurred];
    backgroundImageView.image = blurredImage;
    
    
    
    [self.view addSubview:backgroundImageView];
    
    [self.view addSubview:imageView];

    
//    UILabel *lblName = [[UILabel alloc] init];
//    lblName.text = user.nameString;
//    lblName.font = [UIFont fontWithName:@"Arial" size:22.0];
//   
   
CGSize labelSize = [user.nameString sizeWithFont:[UIFont systemFontOfSize:22.0]constrainedToSize:CGSizeMake(200, 100) lineBreakMode:NSLineBreakByCharWrapping];// 这里限制宽30, 不限制高度
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelSize.width, labelSize.height+50)];
    lblName.text = user.nameString;
    lblName.textColor = [UIColor whiteColor];
    lblName.font = [UIFont fontWithName:@"Arial" size:22.0];

       lblName.center = self.view.center;
                      
    //lblName.textAlignment =
    
//    UILabel *lblGroup = [[UILabel alloc] initWithFrame:CGRectMake(150, 120, 200, 100)];
//    lblGroup.text = [NSString stringWithFormat:@"%@ —— %@",model.memberNl, model.memberXb];
//    lblGroup.font = [UIFont fontWithName:@"Arial" size:14.0];
//    lblGroup.textColor = [UIColor grayColor];
    
    //[self.view addSubview:imageView];
    [self.view addSubview:lblName];
//    [self.view addSubview:lblGroup];

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)LogoutButtonClick:(id)sender
{
    [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil, nil] showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self performSegueWithIdentifier:@"LogoutAction" sender:self];
            break;
            
        default:
            break;
    }
}

@end
