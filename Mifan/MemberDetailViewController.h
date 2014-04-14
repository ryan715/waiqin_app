//
//  MemberDetailViewController.h
//  Mifan
//
//  Created by ryan on 14-4-8.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"

@interface MemberDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) Member *model;
@property (strong, nonatomic) UITableView *listTable;
@end
