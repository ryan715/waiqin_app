//
//  VicinityViewController.h
//  Mifan
//
//  Created by ryan on 13-12-6.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaiqinHttpClient.h"
#import "MBProgressHUD.h"
#import "LocationMeViewController.h"
#import "LocationDetailViewController.h"
#import "KeychainItemWrapper.h"


@interface VicinityViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, WaiqinHttpClientDelegate, LocationMeViewControllerDelegate, LocationDetailViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *locationButton;
@property (retain, nonatomic) KeychainItemWrapper *wrapper;
@property (retain, nonatomic) WaiqinHttpClient *client;
@property (weak, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) UITableView *listTable;

@end
