//
//  GroupNewTableViewController.h
//  Mifan
//
//  Created by ryan on 14-4-24.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroupNewTableViewController;

@protocol GroupNewTableViewControllerDelegate <NSObject>

-(void)newToListDelegate:(GroupNewTableViewController *)view;

@end

@interface GroupNewTableViewController : UITableViewController<UITextFieldDelegate>

@property (nonatomic, weak) id<GroupNewTableViewControllerDelegate> delegate;

- (IBAction)backAction:(id)sender;
- (IBAction)GroupNewClick:(id)sender;
@end


