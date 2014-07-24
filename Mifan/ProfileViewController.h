//
//  ProfileViewController.h
//  Mifan
//
//  Created by ryan on 14-4-7.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "WaiqinHttpClient.h"
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "MBProgressHUD.h"

@interface ProfileViewController : UIViewController<UIActionSheetDelegate>

@property (weak,nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (retain, nonatomic) KeychainItemWrapper *wrapper;
@property (weak, nonatomic) WaiqinHttpClient *client;

@property (nonatomic, strong) FUIButton *logoutButton;

@property (weak, nonatomic) MBProgressHUD *hud;

- (IBAction)LogoutButtonClick:(id)sender;
@end
