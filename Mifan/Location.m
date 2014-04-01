//
//  Location.m
//  Mifan
//
//  Created by ryan on 14-3-31.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "Location.h"

@implementation Location

- (id)initWithCustom:(NSString *)beizhu UserId:(NSString *)userId Longitude:(NSString *)longitude Latitude:(NSString *)latitude Telephone:(NSString *)telephone TrueName:(NSString *)trueName
{
    self = [super init];
    if (self) {
        self.beizhu = beizhu;
        self.userId = userId;
        self.longitude = longitude;
        self.latitude = latitude;
        self.telephone = telephone;
        self.trueName = trueName;
    }
    return self;
}

@end
