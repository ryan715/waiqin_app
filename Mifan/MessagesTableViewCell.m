//
//  MessagesTableViewCell.m
//  Mifan
//
//  Created by ryan on 14-5-24.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "MessagesTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MessagesTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell:(Message *)model{
    //    UIImage *image = [UIImage imageNamed:model.memberImage];
    //    [self.memberImg setImage:image];
    [self.avatarIamgeView setImageWithURL:[NSURL URLWithString: @""]];
    //    NSLog(@"the pic url %@", model.pictureString);
    self.nameLabel.text = model.truenameString;
    self.dateLabel.text = model.createdateString;
    self.messageLabel.text = model.beizhuString;
}


@end
