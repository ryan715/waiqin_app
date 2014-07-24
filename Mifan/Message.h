//
//  Message.h
//  Mifan
//
//  Created by ryan on 14-5-24.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property (strong, nonatomic) NSString *idString;
@property (strong, nonatomic) NSString *truenameString;
@property (strong, nonatomic) NSString *useridString;
@property (strong, nonatomic) NSString *beizhuString;
@property (strong, nonatomic) NSString *ischuliString;
@property (strong, nonatomic) NSString *statusString;
@property (strong, nonatomic) NSString *jjbeizhuString;
@property (strong, nonatomic) NSString *createdateString;
@property (strong, nonatomic) NSString *updatedateString;
@property (strong, nonatomic) NSString *usernameString;

- (id)initWithid:(NSString *)idstring
               userid:(NSString *)userid
           ischuli:(NSString *)ischuli
           status:(NSString *)status
        jjbeizhu:(NSString *)jjbeizhu
            beizhu:(NSString *)beizhu
      createdate:(NSString *)createdate
      updatedate:(NSString *)updatedate
        truename:(NSString *)truename
        username:(NSString *)username;


@end
