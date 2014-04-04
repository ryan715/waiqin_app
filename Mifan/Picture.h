//
//  Picture.h
//  Mifan
//
//  Created by ryan on 14-4-4.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Picture : NSObject

@property (copy, nonatomic) NSString *nameString;
@property (copy, nonatomic) NSString *titleString;
@property (copy, nonatomic) NSString *pictureString;

- (id)initWithName:(NSString *)name Title:(NSString *)title Picture:(NSString *)picture;

@end
