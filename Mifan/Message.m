//
//  Message.m
//  Mifan
//
//  Created by ryan on 14-5-24.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "Message.h"

@implementation Message

- (id)initWithid:(NSString *)idstring userid:(NSString *)userid ischuli:(NSString *)ischuli status:(NSString *)status jjbeizhu:(NSString *)jjbeizhu beizhu:(NSString *)beizhu createdate:(NSString *)createdate updatedate:(NSString *)updatedate truename:(NSString *)truename username:(NSString *)username
{
    self = [super init];
    
    if (self) {
        self.idString = idstring;
        self.useridString  = userid;
        self.ischuliString  = ischuli;
        if ([status isEqualToString:@"0"]) {
            self.statusString = @"未处理";
        } else if ([status isEqualToString:@"1"]) {
            self.statusString = @"已同意";
        } else if([status isEqualToString:@"2"]) {
            self.statusString = @"已拒绝";
        }
//        self.statusString = status;
        self.jjbeizhuString = jjbeizhu;
        self.beizhuString = beizhu;
        self.createdateString = createdate;
        self.updatedateString = updatedate;
        self.truenameString = truename;
        self.usernameString = username;
    }
    
    return self;
}

@end
