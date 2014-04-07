//
//  LoginViewController.h
//  Mifan
//
//  Created by ryan on 13-11-14.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"
#import "WaiqinHttpClient.h"
#import "MBProgressHUD.h"
#import "KeychainItemWrapper.h"
#import "User.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate,RegisterViewControllerDelegate, WaiqinHttpClientDelegate>


@property(weak,nonatomic) IBOutlet UITextField *textName;
@property(weak,nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) MBProgressHUD *hud;
@property (retain, nonatomic) KeychainItemWrapper *wrapper;
@property (retain, nonatomic) User *user;

- (IBAction)Login:(id)sender;

- (IBAction)Register:(id)sender;

@end
