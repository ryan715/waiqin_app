//
//  RegisterViewController.m
//  Mifan
//
//  Created by ryan on 13-11-14.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "RegisterViewController.h"
//#import <Parse/Parse.h>
#import "forwadbackSegue.h"
#import "MBProgressHUD.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize hud;
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
    self.textName.delegate = self;
    self.textPassword.delegate = self;
    self.ConfirmPasswordText.delegate = self;
	// Do any additional setup after loading the view.
    
    /* 点击空白 隐藏键盘 */
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginButton:(id)sender
{
    NSLog(@"LOGIN BUTTON");
    [self.delegate backToLogin:self];
}

- (IBAction)RegisterButton:(id)sender
{
//    PFUser *user = [PFUser user];
//    
//    user.username = self.textName.text;
//    user.password = self.textPassword.text;
//    
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            [self performSegueWithIdentifier:@"Signup" sender:self ];
//        }else{
//            NSString *errorString = [[error userInfo] objectForKey:@"error"];
//            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [errorAlertView show];
//        }
//    }];
    
    NSString *UserName = self.textName.text;
    NSString *UserPassword = self.textPassword.text;
    
    
    if ([self NameBlankString:UserName PasswordBlankString:UserPassword]){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"芒果外勤"
                                                     message:[NSString stringWithFormat:@"%@",@"用户名或者密码错误"]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
        
    }
    else {
        
//        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        self.hud.mode = MBProgressHUDModeIndeterminate;
//        [self.hud show:YES];

        /********* md5 crypto ***********/
        
        const char *cStr = [UserPassword UTF8String];
        unsigned char result[16];
        CC_MD5( cStr, strlen(cStr), result );
        UserPassword = [NSString stringWithFormat:
                        @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                        result[0], result[1], result[2], result[3],
                        result[4], result[5], result[6], result[7],
                        result[8], result[9], result[10], result[11],
                        result[12], result[13], result[14], result[15]
                        ];
    WaiqinHttpClient *client = [WaiqinHttpClient sharedWaiqinHttpClient];
    client.delegate = self;
    
    if (![client isConnectionAvailable]) {
        
        MBProgressHUD *connectHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        connectHud.removeFromSuperViewOnHide =YES;
        connectHud.mode = MBProgressHUDModeText;
        connectHud.labelText = NSLocalizedString(@"网络链接失败", nil);
        connectHud.minSize = CGSizeMake(132.f, 108.0f);
        [connectHud hide:YES afterDelay:3];
        
        [connectHud hide:YES];
        
    } else {
        [client registerAction:UserName Password:UserPassword TrueName:@"" Email:@"" Telephone:@""];
        
        //        [hud hide:YES];
        }
    }

}


- (void)waiqinHTTPClient:(WaiqinHttpClient *)client registerDelegate:(id)responseData
{
    //waiqinHTTPClient
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    NSString *status = [res objectForKey:@"status"];
    NSLog(@"click register");
//    [self.hud hide:YES];
    if ([status isEqualToString:@"1"]) {
        
        UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:@"注册成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [successAlertView show];
       [self performSegueWithIdentifier:@"Signup" sender:self];
    }
    else{
        NSString *errorString = [res objectForKey:@"message"];
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [errorAlertView show];
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare for sege");
    forwadbackSegue *s = (forwadbackSegue *)segue;
    if ([segue.identifier isEqualToString:@"toRegister"]) {
        s.isDismiss = NO;
        NSLog(@"the isdismiss NO");
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
        {
            s.isLandscapeOrientation = YES;
        }
        else
        {
            s.isLandscapeOrientation = NO;
        }

    }else if ([segue.identifier isEqualToString:@"toLogin"]){
        s.isDismiss = YES;
        NSLog(@"the isdismiss NO");
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
        {
            s.isLandscapeOrientation = YES;
        }
        else
        {
            s.isLandscapeOrientation = NO;
        }

    }
    
    
    
    
}

-(BOOL) NameBlankString:(NSString *)StrUsername PasswordBlankString:(NSString *)StrPassword
{
    
    if (StrUsername == nil || StrPassword == nil) {
        return YES;
    }
    if (StrUsername == NULL || StrPassword == NULL) {
        return YES;
    }
    if ([StrUsername isKindOfClass:[NSNull class]] || [StrPassword isKindOfClass:[NSNull class]] ) {
        return YES;
    }
    if ([[StrUsername stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [[StrPassword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    float offset = -80.0f;
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect = CGRectMake(0.0f, offset, width, height);
    self.view.frame = rect;
    [UIView commitAnimations];

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    float offset = 0.0f;
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect = CGRectMake(0.0f, offset, width, height);
    self.view.frame = rect;
    [UIView commitAnimations];
    
    
}



-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.textName resignFirstResponder];
    [self.textPassword resignFirstResponder];
    [self.ConfirmPasswordText resignFirstResponder];
}



@end
