//
//  Picture.m
//  Mifan
//
//  Created by ryan on 14-4-4.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "Picture.h"

@implementation Picture

- (id)initWithName:(NSString *)idpicture Name:(NSString *)name Title:(NSString *)title Picture:(NSString *)picture CreateDate:(NSString *)createDate
{
    self = [super init];
    if (self) {
        self.idString = idpicture;
        self.nameString = name;
        self.titleString = title;
        self.pictureString = picture;
        self.dateString = createDate;
    }
    return self;
}

@end
