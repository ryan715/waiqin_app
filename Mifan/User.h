//
//  User.h
//  Mifan
//
//  Created by ryan on 14-4-7.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (copy, nonatomic) NSString *imageString;
@property (copy, nonatomic) NSString *nameString;
@property (copy, nonatomic) NSString *passwordString;
@property (copy, nonatomic) NSString *groupString;
@property (copy, nonatomic) NSString *idString;

- (id)initWithImage:(NSString *)image
                 name:(NSString *)name
                 pwd:(NSString *)pwd
                 group:(NSString *)group
idString:(NSString *)idString;


@end
