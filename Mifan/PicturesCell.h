//
//  PicturesCell.h
//  Mifan
//
//  Created by ryan on 14-4-4.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Picture.h"
#import "ClickImage.h"

@interface PicturesCell : UITableViewCell

@property (nonatomic,weak) IBOutlet ClickImage *pictureImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

- (void)setupCell:(Picture *)model;

@end
