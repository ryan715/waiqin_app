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
#import "ImageHelper.h"

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
    
//    UIImage *profileImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: model.memberImage]]];
//    
////    圆形化
////    ImageHelper *imageHelper = [[ImageHelper alloc] init];
//    [self.memberImg setImage: [imageHelper ellipseImage:profileImage withInset:0.0]];
////    [self.memberImg setImage:[imageHelper ellipseImage:self.memberImg.image withInset:0.0]];
    
//    NSLog(@"the pic url %@", model.memberNc);
    
    self.nameLabel.text = model.memberNc;
    self.nameLabel.textColor = [UIColor colorWithRed:(float)(102/255.0) green:(float)(204/255.0) blue:(205/255.0) alpha:1.0];
    self.xbLabel.text = model.memberXb;
    
    self.qmLabel.text = model.memberNl;
    
    
    self.memberImg.layer.cornerRadius = self.memberImg.frame.size.width/2;
    self.memberImg.clipsToBounds = YES;
}




@end
