//
//  GroupApplayTableViewController.m
//  Mifan
//
//  Created by ryan on 14-5-20.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "GroupApplayTableViewController.h"
#import "UIPlaceHolderTextView.h"

@interface GroupApplayTableViewController ()
{
    UITextView *applyTextView;
    
}
@end

@implementation GroupApplayTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCustomTextField];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)initCustomTextField
{
    applyTextView.delegate = self;
    UIPlaceHolderTextView *placeTextView = [[UIPlaceHolderTextView alloc] init];
    placeTextView.placeholder = @"";
    placeTextView.frame = CGRectMake(10, 10, 300, 190);
    [placeTextView setFont: [UIFont fontWithName:@"Arial" size:18]];
    placeTextView.delegate = self;
    applyTextView = placeTextView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [applyTextView resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* applyTableViewCellIdentifier = @"applyTable";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:applyTableViewCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: applyTableViewCellIdentifier];
    }
    
    [cell.contentView addSubview:applyTextView];
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleString = @"请填写验证信息";
    return titleString;
}

- (IBAction)sendButtonClick:(id)sender
{
    [self postData];
}

- (void)postData
{
    _client = [WaiqinHttpClient sharedWaiqinHttpClient];
    _client.delegate = self;
    [self getUserID:_client];
}

- (void)getUserID: (WaiqinHttpClient *)waiqinHtppclient
{
    _wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"mango" accessGroup:nil];
    NSString *userName = [_wrapper objectForKey:(__bridge id)kSecAttrAccount];
    NSString *userPassword = [_wrapper objectForKey:(__bridge id)kSecValueData];

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

    [waiqinHtppclient loginActionUser:userName withPassword:userPassword];
}

/*  */
- (void)waiqinHTTPClient:(WaiqinHttpClient *)client didSignin:(id)responseData
{
    NSString *groupIDString = self.group.idString;
    NSString *applyTextString = applyTextView.text;


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

            [_client AddUserApplytoqz:groupIDString Userid:_user.idString Beizhu:applyTextString];
        }
    }
}

- (void)waiqinHTTPClient:(WaiqinHttpClient *)client AddUserApplytoqzDelegate:(id)responseData
{
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    id statusID = [res objectForKey:@"status"];
    NSString *status = @"";
    
    if (statusID != [NSNull null]) {
        status = statusID;
        
        NSString *strMessage = [res objectForKey:@"message"];
        if ([status isEqualToString:@"1"]) {
            UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [successAlertView show];
            //
        } else {
            
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
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
