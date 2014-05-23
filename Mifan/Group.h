//
//  Group.h
//  Mifan
//
//  Created by ryan on 14-5-20.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject
@property (copy, nonatomic) NSString *imageString;
@property (copy, nonatomic) NSString *nameString;
@property (copy, nonatomic) NSString *isDeleteString;
@property (copy, nonatomic) NSString *idString;

- (id)initWithImage:(NSString *)image
               name:(NSString *)name
                isdelete:(NSString *)isdelete
           idString:(NSString *)idString;


@end
