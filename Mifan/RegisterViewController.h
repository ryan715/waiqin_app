//
//  RegisterViewController.h
//  Mifan
//
//  Created by ryan on 13-11-14.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaiqinHttpClient.h"
#import "MBProgressHUD.h"

@class RegisterViewController;

@protocol RegisterViewControllerDelegate <NSObject>

- (void)backToLogin:(RegisterViewController *)viewController;

@end

@interface RegisterViewController : UIViewController<UITextFieldDelegate,WaiqinHttpClientDelegate>

@property (nonatomic,weak) id<RegisterViewControllerDelegate>delegate;
@property (weak, nonatomic) MBProgressHUD *hud;
@property(weak,nonatomic) IBOutlet UITextField *textName;
@property(weak,nonatomic) IBOutlet UITextField *textPassword;
@property(weak,nonatomic) IBOutlet UITextField *ConfirmPasswordText;

- (IBAction)LoginButton:(id)sender;

- (IBAction)RegisterButton:(id)sender;

@end
