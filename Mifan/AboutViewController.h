//
//  AboutViewController.h
//  Mifan
//
//  Created by ryan on 13-12-9.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "WaiqinHttpClient.h"

@interface AboutViewController : UITableViewController<WaiqinHttpClientDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (retain, nonatomic) KeychainItemWrapper *wrapper;
@property (weak, nonatomic) WaiqinHttpClient *client;
@end
