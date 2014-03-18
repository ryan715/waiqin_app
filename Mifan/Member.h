//
//  Member.h
//  Mifan
//
//  Created by ryan on 13-11-15.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject

@property (copy, nonatomic) NSString *memberImage;
@property (copy, nonatomic) NSString *memberNc;
@property (copy, nonatomic) NSString *memberXb;
@property (copy, nonatomic) NSString *memberNl ;

- (id)initWithImage:(NSString *)image
                 Nc:(NSString *)nc
                 Xb:(NSString *)xb
                 Nl:(NSString *)nl;



@end
