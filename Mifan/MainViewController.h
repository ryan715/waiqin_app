//
//  MainViewController.h
//  Mifan
//
//  Created by ryan on 13-11-14.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "KeychainItemWrapper.h"
#import "WaiqinHttpClient.h"

@interface MainViewController : UITableViewController<WaiqinHttpClientDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (retain, nonatomic) KeychainItemWrapper *wrapper;

@property (weak, nonatomic) WaiqinHttpClient *client;

@end
