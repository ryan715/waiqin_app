//
//  Message.m
//  Mifan
//
//  Created by ryan on 14-5-24.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "Message.h"

@implementation Message

- (id)initWithid:(NSString *)idstring userid:(NSString *)userid ischuli:(NSString *)ischuli status:(NSString *)status jjbeizhu:(NSString *)jjbeizhu beizhu:(NSString *)beizhu createdate:(NSString *)createdate updatedate:(NSString *)updatedate truename:(NSString *)truename
{
    self = [super init];
    
    if (self) {
        self.idString = idstring;
        self.useridString  = userid;
        self.ischuliString  = ischuli;
        self.statusString = status;
        self.jjbeizhuString = jjbeizhu;
        self.beizhuString = beizhu;
        self.createdateString = createdate;
        self.updatedateString = updatedate;
        self.truenameString = truename;
    }
    
    return self;
}

@end
