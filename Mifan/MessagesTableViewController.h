//
//  MessagesTableViewController.h
//  Mifan
//
//  Created by ryan on 14-5-24.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "WaiqinHttpClient.h"

@interface MessagesTableViewController : UITableViewController<WaiqinHttpClientDelegate>

@property (retain, nonatomic) KeychainItemWrapper *wrapper;
@property (retain, nonatomic) WaiqinHttpClient *client;
@property (nonatomic, weak)IBOutlet UIBarButtonItem *sidebarButton;
- (void) createTableFooter;
- (void) loadDataBegin;
- (void) loadDataing;
- (void) loadDataEnd;

@end
