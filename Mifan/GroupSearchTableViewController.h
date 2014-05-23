//
//  GroupSearchTableViewController.h
//  Mifan
//
//  Created by ryan on 14-5-13.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"

@class GroupSearchTableViewController;

@protocol GroupSearchTableViewControllerDelegate <NSObject>



@end

@interface GroupSearchTableViewController : UITableViewController
@property (nonatomic, weak) id<GroupSearchTableViewControllerDelegate>delegate;
@property (nonatomic, retain) Group *groupModel;

@end
