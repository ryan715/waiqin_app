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

@interface ProfileViewController : UIViewController

@property (weak,nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (retain, nonatomic) KeychainItemWrapper *wrapper;
@property (weak, nonatomic) WaiqinHttpClient *client;
@end
