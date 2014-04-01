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

@interface LoginViewController : UIViewController<UITextFieldDelegate,RegisterViewControllerDelegate, WaiqinHttpClientDelegate>


@property(weak,nonatomic) IBOutlet UITextField *textName;
@property(weak,nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) MBProgressHUD *hud;

- (IBAction)Login:(id)sender;

- (IBAction)Register:(id)sender;

@end
