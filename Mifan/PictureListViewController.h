//
//  PictureListViewController.h
//  Mifan
//
//  Created by ryan on 14-4-2.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureListViewController : UITableViewController<UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, weak)IBOutlet UIBarButtonItem *sidebarButton;

- (IBAction)photoAction:(id)sender;
@end
