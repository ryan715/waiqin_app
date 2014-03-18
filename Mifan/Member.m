//
//  Member.m
//  Mifan
//
//  Created by ryan on 13-11-15.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "Member.h"

@implementation Member

- (id)initWithImage:(NSString *)image
              Nc:(NSString *)nc
                 Xb:(NSString *)xb
                 Nl:(NSString *)nl

{
    self = [super init];
    
    if (self) {
        self.memberImage = image;
        self.memberNc  = nc;
        self.memberXb  = xb;
        self.memberNl  = nl;
    }
    
    return self;
}





@end
