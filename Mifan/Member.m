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
                Email:(NSString *)email Telephone:(NSString *)telephone

{
    self = [super init];
    
    if (self) {
        self.memberImage = image;
        self.memberNc  = nc;
        
        if ([xb isEqualToString:@"0"]) {
            self.memberXb = @"成员";
        } else {
            self.memberXb = @"群主";
        }

        //self.memberXb  = xb;
        self.memberNl  = nl;
        self.emailString =email;
        self.telephoneString = telephone;
    }
    
    return self;
}





@end
