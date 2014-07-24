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
#import "KeychainItemWrapper.h"

@class RegisterViewController;

@protocol RegisterViewControllerDelegate <NSObject>

- (void)backToLogin:(RegisterViewController *)viewController;

@end

@interface RegisterViewController : UIViewController<UITextFieldDelegate,WaiqinHttpClientDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITextField *accountTextField;
    UITextField *passwordTextField;
    UITextField *conPasswordTextField;
}
@property (nonatomic,weak) id<RegisterViewControllerDelegate>delegate;
@property (weak, nonatomic) MBProgressHUD *hud;
@property(weak,nonatomic) IBOutlet UITextField *textName;
@property(weak,nonatomic) IBOutlet UITextField *textPassword;
@property(weak,nonatomic) IBOutlet UITextField *ConfirmPasswordText;

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *textFieldArrays;
@property (nonatomic, retain) KeychainItemWrapper *wrapper;


- (IBAction)LoginButton:(id)sender;

- (IBAction)RegisterButton:(id)sender;

@end
