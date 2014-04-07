//
//  User.m
//  Mifan
//
//  Created by ryan on 14-4-7.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithImage:(NSString *)image name:(NSString *)name pwd:(NSString *)pwd group:(NSString *)group idString:(NSString *)idString
{
    self = [super init];
    
    if (self) {
        self.imageString = image;
        self.nameString  = name;
        self.passwordString  = pwd;
        self.groupString  = group;
        self.idString = idString;
    }
    
    return self;
}

@end
