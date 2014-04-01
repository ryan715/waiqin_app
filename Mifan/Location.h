//
//  Location.h
//  Mifan
//
//  Created by ryan on 14-3-31.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (copy, nonatomic) NSString *beizhu;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *longitude;
@property (copy, nonatomic) NSString *latitude;
@property (copy, nonatomic) NSString *telephone;
@property (copy, nonatomic) NSString *trueName;

- (id)initWithCustom:(NSString *)beizhu UserId:(NSString *)userId Longitude:(NSString *)longitude Latitude:(NSString *)latitude Telephone:(NSString *)telephone TrueName:(NSString *)trueName;
@end
