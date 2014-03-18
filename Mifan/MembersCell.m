//
//  MemberCellsCell.m
//  Mifan
//
//  Created by ryan on 13-11-15.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "MembersCell.h"
#import "Member.h"

@implementation MembersCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell:(Member *)model{
    UIImage *image = [UIImage imageNamed:model.memberImage];
    [self.memberImg setImage:image];
    
    self.nameLabel.text = model.memberNc;
    self.xbLabel.text = model.memberXb;
    self.qmLabel.text = model.memberNl;
}


@end
