//
//  LoginViewController.m
//  Mifan
//
//  Created by ryan on 13-11-14.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
//#import <Parse/Parse.h>

#import <CommonCrypto/CommonDigest.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)Register:(id)sender
{
    [self performSegueWithIdentifier:@"toRegister" sender:self];

}


- (IBAction)Login:(id)sender
{
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
//    NSString *UserName = @"a005";
//    NSString *UserPassword = @"1";
    
    
    
    
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
    
    
    /********* end  md5 crypto ***********/
//
//    [PFUser logInWithUsernameInBackground:UserName password:UserPassword block:^(PFUser *user, NSError *error) {
//        if (user) {
//             [self performSegueWithIdentifier:@"toMain" sender:self];
//        }else{
//            NSString *errorString = [[error userInfo] objectForKey:@"error"];
//            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [errorAlertView show];
//            
//        }
//    }];
    NSLog(@"begin");
    WaiqinHttpClient *client = [WaiqinHttpClient sharedWaiqinHttpClient];
    client.delegate = self;
    [client loginActionUser:UserName withPassword:UserPassword];
    }
}

- (void)waiqinHTTPClient:(WaiqinHttpClient *)client didSignin:(id)user
{
    //waiqinHTTPClient
    NSDictionary *res = [user objectForKey:@"wsr"];
    NSString *status = [res objectForKey:@"status"];
    if ([status isEqualToString:@"1"]) {
        [self performSegueWithIdentifier:@"toMain" sender:self];
    }
    else{
        NSString *errorString = [res objectForKey:@"message"];
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                   [errorAlertView show];

    }
//    NSLog(@"THE status IS %@",status);
//    id lists = [res objectForKey:@"lists"];
//    NSArray *array = lists;
//    NSDictionary *dic = [array objectAtIndex:0];
//    //NSDictionary *list = [lists objectFromJSONData];
//    NSString *department = [dic objectForKey:@"telephone"];
////    NSDictionary *lists = [res objectForKey:@"lists"];
////
//  NSLog(@"THE department IS %@",department);


}


- (void)backToLogin:(RegisterViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare for sege");
    if ([segue.identifier isEqualToString:@"toRegister"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        RegisterViewController *registerViewController = [[navigationController viewControllers] objectAtIndex:0];
        registerViewController.delegate = self;
    
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


@end
