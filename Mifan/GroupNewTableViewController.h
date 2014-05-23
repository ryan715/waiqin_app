//
//  GroupNewTableViewController.h
//  Mifan
//
//  Created by ryan on 14-4-24.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaiqinHttpClient.h"
#import "MBProgressHUD.h"
#import "KeychainItemWrapper.h"
#import "User.h"

@class GroupNewTableViewController;

@protocol GroupNewTableViewControllerDelegate <NSObject>

-(void)newToListDelegate:(GroupNewTableViewController *)view;

@end

@interface GroupNewTableViewController : UITableViewController<UITextFieldDelegate, WaiqinHttpClientDelegate>

@property (nonatomic, weak) id<GroupNewTableViewControllerDelegate> delegate;
@property (weak, nonatomic) MBProgressHUD *hud;
@property (retain, nonatomic) KeychainItemWrapper *wrapper;
@property (retain, nonatomic) User *user;
@property (retain, nonatomic) WaiqinHttpClient *client;
- (IBAction)backAction:(id)sender;
- (IBAction)GroupNewClick:(id)sender;
@end


