//
//  Picture.m
//  Mifan
//
//  Created by ryan on 14-4-4.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "Picture.h"

@implementation Picture

- (id)initWithName:(NSString *)name Title:(NSString *)title Picture:(NSString *)picture
{
    self = [super init];
    if (self) {
        self.nameString = name;
        self.titleString = title;
        self.pictureString = picture;
    }
    return self;
}

@end
