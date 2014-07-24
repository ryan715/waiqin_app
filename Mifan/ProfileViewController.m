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
#import "Photo.h"
#import "Member.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ProfileViewController ()
{
    User *user;
    Member * memberModel;
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
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.hud show:YES];
    
    [self getUserAction];
    [self customController];

//    [self.hud hide:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)customController {
    self.logoutButton = [[FUIButton alloc] init];
    CGRect buttonFrame = CGRectMake(60, 480, 200, 40);
    self.logoutButton.frame = buttonFrame;
    self.logoutButton.buttonColor = [UIColor turquoiseColor];
    self.logoutButton.cornerRadius = 3.0f;
    self.logoutButton.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    [self.logoutButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.logoutButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.logoutButton setTitle:@"注  销 " forState:UIControlStateNormal];
    [self.logoutButton addTarget:self action:@selector(LogoutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.logoutButton];
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
        
        [_client GetOneUserforqunzhuAction:user.idString];
        //[self customUser:@""];
        
    }
}


/* 获取用户信息 */
- (void) waiqinHTTPClient: (WaiqinHttpClient *) client getOneUserforqunzhuDelegate: (id) responseData{
    NSLog(@"check getOneUserforqunzhuDelegate");
    
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    NSString *status = [res objectForKey:@"status"];
    if ([status isEqualToString:@"1"]) {
        NSDictionary *dictionaryList;
        NSArray *arrayList = [res objectForKey:@"lists"];
        dictionaryList = [arrayList objectAtIndex: 0];
       
    NSString *urlString = [NSString stringWithFormat:@"http://72.14.191.249:8080/ExpertSelectSystemV1.1%@", [dictionaryList objectForKey:@"imgstr"]];
    
    memberModel = [[Member alloc] initWithImage:urlString Nc:[dictionaryList objectForKey:@"username"] Xb:[dictionaryList objectForKey:@"isqunzhu"] Nl:[dictionaryList objectForKey:@"unitname"] Email:[dictionaryList objectForKey:@"email"] Telephone:[dictionaryList objectForKey:@"telephone"]];
        NSLog(@"the member url is %@", memberModel.memberImage);
        [self customUser:memberModel.memberImage];
    }

}



- (void)customUser: (NSString *)imageURLString
{
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    NSData *profileImageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *profileImage = [UIImage imageWithData:profileImageData];
    
//    UIImage *profileImage = [NSURL URLWithString: imageURLString];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [imageView setImageWithURL:[NSURL URLWithString: imageURLString]];
    imageView.layer.cornerRadius = imageView.frame.size.width /2;
    imageView.clipsToBounds = YES;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
//    ImageHelper *imageHelper = [[ImageHelper alloc] init];
//    setImageWithURL:[NSURL URLWithString: model.memberImage]
    
//    imageView.image  = [imageHelper ellipseImage:profileImage withInset:0.0];
//    return imageView;
    
    
    imageView.contentMode = UIViewContentModeCenter;
    imageView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2-100);
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent)];
//    singleTap.numberOfTouchesRequired = 1;
//    singleTap.numberOfTapsRequired = 1;
//    singleTap.delegate = self;
    [imageView addGestureRecognizer:singleTap];
    imageView.userInteractionEnabled = YES;
    
    UIImage *profileBackgroundImage = [NSURL URLWithString: imageURLString];//[UIImage imageNamed:@"tx1.jpg"];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 300)];
  
    
    // jpeg quality image data
    float quality = .00001f;
    // intensity of blurred
    float blurred = .5f;
    NSData *imageData = UIImageJPEGRepresentation(profileImage, quality);
    UIImage *blurredImage = [[UIImage imageWithData:imageData] blurredImage:blurred];
    backgroundImageView.image = blurredImage;
    
    
    
    [self.view addSubview:backgroundImageView];
    
    [self.view addSubview:imageView];

    
//    UILabel *lblName = [[UILabel alloc] init];
//    lblName.text = user.nameString;
//    lblName.font = [UIFont fontWithName:@"Arial" size:22.0];
//   
   
CGSize labelSize = [memberModel.memberNc sizeWithFont:[UIFont systemFontOfSize:22.0]constrainedToSize:CGSizeMake(400, 100) lineBreakMode:NSLineBreakByCharWrapping];// 这里限制宽30, 不限制高度
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelSize.width+5, labelSize.height+50)];
    lblName.text = memberModel.memberNc;
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


- (void)handleSingleFingerEvent
{
    UIActionSheet *picActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [picActionSheet showInView:[self view]];
    picActionSheet.tag = 101;
    
}


/* 处理图片 */

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *photoImage = [self scaleImage:originImage toScale:0.3];
    NSString *photoString = [Photo image2String: photoImage];

    [_client GetUpdatetxUserforqunzhuAction:photoString UserId:user.idString];
    [picker dismissModalViewControllerAnimated:NO];
    
    //[self performSegueWithIdentifier:@"toPictureNew" sender:self];
}



- (void)waiqinHTTPClient:(WaiqinHttpClient *)client getUpdatetxUserforqunzhuDelegate:(id)responseData
{
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    NSString *status = [res objectForKey:@"status"];
//    NSString *successMsg = [res objectForKey:@"msg"];
    NSString *successMsg = @"操作成功";
    if ([status isEqualToString:@"1"]) {
//        NSDictionary *dictionaryList;
//        NSArray *arrayList = [res objectForKey:@"lists"];
//        dictionaryList = [arrayList objectAtIndex: 0];
//        user = [[User alloc] initWithImage:@"" name: [dictionaryList objectForKey:@"username"] pwd:[dictionaryList objectForKey:@"password"] group:[dictionaryList objectForKey:@"unitname"] idString:[dictionaryList objectForKey:@"id"]];
//        
//        [self customUser:@""];
        UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:successMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [AlertView show];

//        NSLog(@"update image success");
        [self getUserAction];
    }

}


- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSzie
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSzie, image.size.height *scaleSzie));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSzie, image.size.height * scaleSzie)];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
    
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
    UIActionSheet *logoutActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil, nil];
    [logoutActionSheet showInView:self.view];
    logoutActionSheet.tag = 102;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 102) {
        
   
    switch (buttonIndex) {
        case 0:
            [self performSegueWithIdentifier:@"LogoutAction" sender:self];
            break;
            
        default:
            break;
    }
    }else if(actionSheet.tag == 101){
    
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

}

@end
