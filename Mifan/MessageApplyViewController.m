//
//  MessageApplyViewController.m
//  Mifan
//
//  Created by ryan on 14-5-27.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "MessageApplyViewController.h"
#import "Message.h"

#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"

@interface MessageApplyViewController ()

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MessageApplyViewController
@synthesize message;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 320, 600) style:UITableViewStyleGrouped];
//    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
//    NSLog(@"the message is %@", message.idString);
    
    CGRect footerFrame = CGRectMake(0, 200, 320, 200);
    UIView *footer =[[ UIView alloc] initWithFrame:footerFrame];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    
//    UIButton *acceptButton = [[UIButton alloc] initWithFrame:CGRectMake(20, footerFrame.size.height/2, footerFrame.size.width - 20*2 , 40)];
//    acceptButton.layer.cornerRadius = 2;
//    acceptButton.layer.borderWidth = 1;
//    acceptButton.layer.borderColor = [UIColor blueColor].CGColor;
//    [acceptButton setTitle:@"接受" forState:UIControlStateNormal];
//    [acceptButton sizeToFit];
//    [acceptButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    NSLog(@"check ischuli %@", self.message.ischuliString);
    if ([self.message.ischuliString isEqualToString:@"1"]) {
        
    } else {
    
    FUIButton *acceptButton = [[FUIButton alloc]init];
    CGRect buttonFrame = CGRectMake(40, 50, 240, 40);
    acceptButton.frame = buttonFrame;
    acceptButton.buttonColor = [UIColor greenSeaColor];
    //    self.submitButton.shadowColor = [UIColor greenSeaColor];
    //    self.submitButton.shadowHeight = 3.0f;
    acceptButton.cornerRadius = 0.0f;
    acceptButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [acceptButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [acceptButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [acceptButton setTitle:@"接  受" forState:UIControlStateNormal];
    
//    [acceptButton addTarget:self action:@selector(toLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:acceptButton];
    
    acceptButton.tag = 1001;
    [acceptButton addTarget:self action:@selector(acceptButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *rejectionButton = [[UIButton alloc] initWithFrame:CGRectMake(20, footerFrame.size.height/2 +50, footerFrame.size.width - 20*2 , 40)];
//    rejectionButton.layer.cornerRadius = 2;
//    rejectionButton.layer.borderWidth = 1;
//    rejectionButton.layer.borderColor = [UIColor blueColor].CGColor;
//    [rejectionButton setTitle:@"拒绝" forState:UIControlStateNormal];
//    [rejectionButton sizeToFit];
//    [rejectionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    FUIButton *rejectionButton = [[FUIButton alloc]init];
    CGRect rbuttonFrame = CGRectMake(40, 100, 240, 40);
    rejectionButton.frame = rbuttonFrame;
    rejectionButton.buttonColor = [UIColor sunflowerColor];
    //    self.submitButton.shadowColor = [UIColor greenSeaColor];
    //    self.submitButton.shadowHeight = 3.0f;
    rejectionButton.cornerRadius = 0.0f;
    rejectionButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [rejectionButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [rejectionButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [rejectionButton setTitle:@"拒  绝" forState:UIControlStateNormal];
        
    [rejectionButton addTarget:self action:@selector(rejectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [footer addSubview:rejectionButton];
    }

}

- (void)acceptButtonClick:(UIButton *)sender
{
//    NSLog(@"click the acception");
    self.statusString = @"1";
    [self loadData];
}

- (void)rejectionButtonClick:( UIButton *)sender
{
    self.statusString = @"2";
    [self loadData];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@     %@",self.message.usernameString, self.message.createdateString];
    } if (indexPath.row == 1) {
        cell.textLabel.text = self.message.beizhuString;
    }

    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* 载入个人数据 */
- (void)loadData
{
    _wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"mango" accessGroup:nil];
    NSString *userName = [_wrapper objectForKey:(__bridge id)kSecAttrAccount];
    NSString *userPassword = [_wrapper objectForKey:(__bridge id)kSecValueData];
    
    _client = [WaiqinHttpClient sharedWaiqinHttpClient];
    const char *cStr = [userPassword UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    userPassword = [NSString stringWithFormat:
                    @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                    result[0], result[1], result[2], result[3],
                    result[4], result[5], result[6], result[7],
                    result[8], result[9], result[10], result[11],
                    result[12], result[13], result[14], result[15]
                    ];
    
    _client.delegate = self;
    [_client loginActionUser:userName withPassword:userPassword];
}

/* 提交 群名称 */
- (void)waiqinHTTPClient:(WaiqinHttpClient *)client didSignin:(id)responseData
{
    
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    id statusID = [res objectForKey:@"status"];
    NSString *status = @"";
    
    if (statusID != [NSNull null]) {
        status = statusID;
        if ([status isEqualToString:@"1"]) {
            NSDictionary *dictionaryList;
            NSArray *arrayList = [res objectForKey:@"lists"];
            dictionaryList = [arrayList objectAtIndex: 0];
            self.user = [[User alloc] initWithImage:@"" name: [dictionaryList objectForKey:@"username"] pwd:[dictionaryList objectForKey:@"password"] group:[dictionaryList objectForKey:@"unitname"] idString:[dictionaryList objectForKey:@"id"]];
            
            if ([self.statusString isEqualToString:@"1"]) {
                [_client UpdateUserqzApplytosq:@"1" ApplyID:self.message.idString UserID:self.user.idString Jjbeizhu:@""];

            } else {
                [_client UpdateUserqzApplytosq:@"0" ApplyID:self.message.idString UserID:self.user.idString Jjbeizhu:@""];            }
        }
    }
}

/* 处理提交 反馈 */
- (void)waiqinHTTPClient:(WaiqinHttpClient *)client UpdateUserqzApplytosqDelegate:(id)responseData
{
    
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    id statusID = [res objectForKey:@"status"];
    NSString *status = @"";
    
    if (statusID != [NSNull null]) {
        status = statusID;
        if ([status isEqualToString:@"1"]) {
            UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:@"提交成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [successAlertView show];
            //
        } else {
            NSString *strMessage = [res objectForKey:@"message"];
            UIAlertView *errAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errAlertView show];
            //
        }
    }
}

- (void)waiqinHTTPClient:(WaiqinHttpClient *)client didFailWithError:(NSError *)error
{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:@"提交失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [errorAlertView show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
