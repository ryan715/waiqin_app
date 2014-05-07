//
//  PictureListViewController.h
//  Mifan
//
//  Created by ryan on 14-4-2.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "WaiqinHttpClient.h"

@interface PictureListViewController : UITableViewController<UIImagePickerControllerDelegate, UIActionSheetDelegate, WaiqinHttpClientDelegate>

@property (nonatomic, weak)IBOutlet UIBarButtonItem *sidebarButton;
@property (retain, nonatomic) KeychainItemWrapper *wrapper;
@property (retain, nonatomic) WaiqinHttpClient *client;

- (IBAction)photoAction:(id)sender;


- (void) createTableFooter;
- (void) loadDataBegin;
- (void) loadDataing;
- (void) loadDataEnd;
@end
