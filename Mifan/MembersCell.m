//
//  MemberCellsCell.m
//  Mifan
//
//  Created by ryan on 13-11-15.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "MembersCell.h"
#import "Member.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
//    UIImage *image = [UIImage imageNamed:model.memberImage];
//    [self.memberImg setImage:image];

    
    [self.memberImg setImageWithURL:[NSURL URLWithString: model.memberImage]];
//    NSLog(@"the pic url %@", model.pictureString);
    
    self.nameLabel.text = model.memberNc;
    self.xbLabel.text = model.memberXb;
    
//    if ([model.memberXb isEqualToString:@"0"]) {
//        self.xbLabel.text = @"群员";
//    } else {
//        self.xbLabel.text = @"群主";
//    }
    self.qmLabel.text = model.memberNl;
}


@end
