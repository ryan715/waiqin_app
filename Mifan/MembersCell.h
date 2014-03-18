//
//  MemberCellsCell.h
//  Mifan
//
//  Created by ryan on 13-11-15.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"

@interface MembersCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *memberImg;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *xbLabel;
@property (strong, nonatomic) IBOutlet UILabel *qmLabel;

-(void)setupCell:(Member *)model;



@end
