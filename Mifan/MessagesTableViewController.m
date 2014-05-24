//
//  MessagesTableViewController.m
//  Mifan
//
//  Created by ryan on 14-5-24.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "MessagesTableViewController.h"
#import "User.h"
#import "Hint.h"
#import "Message.h"
#import "MessagesTableViewCell.h"
#import "SWRevealViewController.h"

@interface MessagesTableViewController ()
{
    NSMutableArray *itemList;
    
    NSMutableArray *moreArray;
    User *user;
    Hint *h;
    
    int dataNumber;
    BOOL _loadingMore;
    int pageNumber;
}
@end

@implementation MessagesTableViewController

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
    self.title = @"我的信息";
    itemList = [[NSMutableArray alloc] init];
    moreArray = [[NSMutableArray alloc] init];
    
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    [self getData];
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
    
    return itemList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MessageTableViewCellIdentifier = @"MessagesCellIdentifier";
    static BOOL isRegNib = NO;
    if (!isRegNib) {
        [self.tableView registerNib:[UINib nibWithNibName:@"MessagesTableViewCell" bundle:nil ] forCellReuseIdentifier:MessageTableViewCellIdentifier];
        isRegNib = YES;
    }
    
    MessagesTableViewCell *cell= [self.tableView dequeueReusableCellWithIdentifier:MessageTableViewCellIdentifier];
    [cell setupCell:itemList[indexPath.row]];
    
    if (cell == nil) {
        [self.tableView registerNib:[UINib nibWithNibName:@"MessagesTableViewCell" bundle:nil ] forCellReuseIdentifier:MessageTableViewCellIdentifier];
        MessagesTableViewCell *cell1= [self.tableView dequeueReusableCellWithIdentifier:MessageTableViewCellIdentifier];
        [cell1 setupCell:itemList[indexPath.row]];
        cell = cell1;
    }
    
    return cell;
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



/* 获取服务端数据 */
- (void)getData
{
    _client = [WaiqinHttpClient sharedWaiqinHttpClient];
    _client.delegate = self;
    [self getUserID:_client];

    
}

/*  */
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
            user = [[User alloc] initWithImage:@"" name: [dictionaryList objectForKey:@"username"] pwd:[dictionaryList objectForKey:@"password"] group:[dictionaryList objectForKey:@"unitname"] idString:[dictionaryList objectForKey:@"id"]];
            
            [_client GetUserApplytoqzlist:@"1" PageSize:@"15" UserID:user.idString];
        }
    }
}


- (void)waiqinHTTPClient:(WaiqinHttpClient *)client GetUserApplytoqzlistDelegate:(id)responseData
{
    NSLog(@"the response data is %@",[responseData objectForKey:@"wsr"]);
    
    //   清空数据
    //    itemList = nil;
    
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    NSString *status = [res objectForKey:@"status"];
    
    if ([status isEqualToString:@"1"]) {
        NSDictionary *dictionaryList;
        
        id idCount = [responseData objectForKey:@"count"];
        NSString *strCount = @"";
        
        if (idCount != [NSNull null]) {
            strCount = idCount;
            NSLog(@"CHECK");
            if (![strCount isEqualToString:@"0"]) {
                
                dataNumber = [strCount intValue];
                
                NSArray *arrayList = [res objectForKey:@"lists"];
                [moreArray removeAllObjects];
                //        NSLog(@"the array list is %d", arrayList.count);
                for (int i= 0; i< arrayList.count; i++) {
                    dictionaryList = [arrayList objectAtIndex:i];
                    
                    Message *model = [[Message alloc] initWithid:[dictionaryList objectForKey:@"id"] userid:[dictionaryList objectForKey:@"userid"]  ischuli:[dictionaryList objectForKey:@"ischuli"]  status:[dictionaryList objectForKey:@"status"]  jjbeizhu:[dictionaryList objectForKey:@"jjbeizhu"]  beizhu:[dictionaryList objectForKey:@"beizhu"]  createdate:[dictionaryList objectForKey:@"createdate"]  updatedate:[dictionaryList objectForKey:@"updatedate"]  truename:[dictionaryList objectForKey:@"truename"]];
                    
                    [moreArray addObject:model];
                    //            NSLog(@"the pic list is %d", itemList.count);
                    
                }
                NSLog(@"THE moreArray COUNT IS %d", [moreArray count]);
                for (int j=0; j<[moreArray count]; j++) {
                    [itemList addObject:[moreArray objectAtIndex:j]];
                }
                NSLog(@"THE ITEMLIST COUNT IS %d", [itemList count]);
                [self.tableView reloadData];
                //[self createTableFooter];
                
            } else {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"芒果外勤"
                                                             message:@"当前无数据"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av show];
            }
        }
        
        
    } else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"芒果外勤"
                                                     message:@"加载失败"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
