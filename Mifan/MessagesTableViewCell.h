//
//  MessagesTableViewCell.h
//  Mifan
//
//  Created by ryan on 14-5-24.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessagesTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *avatarIamgeView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

-(void)setupCell:(Message *)model;

@end
