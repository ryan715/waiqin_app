//
//  PicturesCell.m
//  Mifan
//
//  Created by ryan on 14-4-4.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "PicturesCell.h"
#import "Picture.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation PicturesCell

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

- (void)setupCell:(Picture *)model
{
    [self.pictureImageView setImageWithURL:[NSURL URLWithString: model.pictureString]];
    
//    self.pictureImageView.canClick = YES;
//    [self.pictureImageView setClickToViewController:h];
    
//    [self.pictureImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)]];

    NSLog(@"the pic url %@", model.pictureString);
    self.nameLabel.text = model.nameString;
    self.titleLabel.text = model.titleString;
}


//- (void)BtnClick:(UITapGestureRecognizer *)imageTap
//{
//    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"芒果外勤"
//                                                 message:@"click ok"
//                                                delegate:nil
//                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [av show];
//}

@end
