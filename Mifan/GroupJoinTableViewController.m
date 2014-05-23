//
//  GroupJoinTableViewController.m
//  Mifan
//
//  Created by ryan on 14-4-24.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "GroupJoinTableViewController.h"
#import "GroupSearchTableViewController.h"
#import "Group.h"

@interface GroupJoinTableViewController ()
{
    UITextField *GroupNameTextField;

}
@end

@implementation GroupJoinTableViewController
@synthesize group;


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
    self.title = @"加入群组";
    
    [self initCustomTextField];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    static NSString *GroupNewTableIdentifier = @"GroupJoin";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GroupNewTableIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GroupNewTableIdentifier];
    }
    // Configure the cell...
    [cell.contentView addSubview:GroupNameTextField];
    return cell;
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
*/
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"searchGroupIdentifier"]) {
        
        GroupSearchTableViewController *groupSearch = segue.destinationViewController;
        groupSearch.delegate = self;
        groupSearch.groupModel = group;
//        NSLog(@"the group name is %@", group.nameString);
    }

}


- (IBAction)searchButtonClick:(id)sender
{
//    [self performSegueWithIdentifier:@"searchGroupIdentifier" sender:self];
    
    [self loadData];

}

- (void)initCustomTextField
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 300, 25)];
    
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    GroupNameTextField = textField;
    GroupNameTextField.delegate = self;
    textField.placeholder = @"输入群名称";
    
}

/* 载入个人数据 */
- (void)loadData
{
//    _wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"mango" accessGroup:nil];
//    NSString *userName = [_wrapper objectForKey:(__bridge id)kSecAttrAccount];
//    NSString *userPassword = [_wrapper objectForKey:(__bridge id)kSecValueData];
//    
   _client = [WaiqinHttpClient sharedWaiqinHttpClient];
//    const char *cStr = [userPassword UTF8String];
//    unsigned char result[16];
//    CC_MD5( cStr, strlen(cStr), result );
//    userPassword = [NSString stringWithFormat:
//                    @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//                    result[0], result[1], result[2], result[3],
//                    result[4], result[5], result[6], result[7],
//                    result[8], result[9], result[10], result[11],
//                    result[12], result[13], result[14], result[15]
//                    ];
//    
    _client.delegate = self;
    [_client GetUnitByName: GroupNameTextField.text];
}

///* 提交 群名称 */
//- (void)waiqinHTTPClient:(WaiqinHttpClient *)client didSignin:(id)responseData
//{
//    
//    NSDictionary *res = [responseData objectForKey:@"wsr"];
//    id statusID = [res objectForKey:@"status"];
//    NSString *status = @"";
//    
//    if (statusID != [NSNull null]) {
//        status = statusID;
//        if ([status isEqualToString:@"1"]) {
//            NSDictionary *dictionaryList;
//            NSArray *arrayList = [res objectForKey:@"lists"];
//            dictionaryList = [arrayList objectAtIndex: 0];
//            self.user = [[User alloc] initWithImage:@"" name: [dictionaryList objectForKey:@"username"] pwd:[dictionaryList objectForKey:@"password"] group:[dictionaryList objectForKey:@"unitname"] idString:[dictionaryList objectForKey:@"id"]];
//            
//            [_client GetUnitByName: GroupNameTextField.text];
//        }
//    }
//}

/* 处理提交 反馈 */
- (void)waiqinHTTPClient:(WaiqinHttpClient *)client GetUnitByNameDelegate:(id)responseData
{
    
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    NSLog(@"THE GetUnitByNameDelegate %@", res);
    id statusID = [res objectForKey:@"status"];
    NSString *status = @"";
    if (statusID != [NSNull null]) {
        status = statusID;
//        NSString *messageString = [res objectForKey:@"message"];
        if ([status isEqualToString:@"1"]) {
//            UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:messageString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [successAlertView show];
            
            NSDictionary *dictionaryList;
            NSArray *arrayList = [res objectForKey:@"lists"];
            dictionaryList = [arrayList objectAtIndex: 0];

            group = [[Group alloc] initWithImage:@"" name:[dictionaryList objectForKey: @"unitname"] isdelete:[dictionaryList objectForKey:@"isdelete"] idString:[dictionaryList objectForKey:@"id"]];
//            NSLog(@"statis is 1 group is %@", group.nameString);
            [self performSegueWithIdentifier:@"searchGroupIdentifier" sender:self];

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
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:@"创建失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [errorAlertView show];
}






@end
