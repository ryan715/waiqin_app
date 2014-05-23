//
//  Group.m
//  Mifan
//
//  Created by ryan on 14-5-20.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "Group.h"

@implementation Group

- (id)initWithImage:(NSString *)image name:(NSString *)name isdelete:(NSString *)isdelete idString:(NSString *)idString
{
    self = [super init];
    
    if (self) {
        self.imageString = image;
        self.nameString  = name;
        self.isDeleteString  = isdelete;
        self.idString = idString;
    }
    
    return self;
}

@end
