//
//  MainViewController.m
//  Mifan
//
//  Created by ryan on 13-11-14.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "Member.h"
#import "MembersCell.h"

@interface MainViewController ()
{
    NSArray *_dataArray;
    NSMutableArray *_dataList;
}

@end

@implementation MainViewController

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
    
    //_sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.title = @"邂逅";
    
    NSLog(@"load this data");
    // 初始化数据数组
    _dataArray = @[@[@"tx1.jpg", @"∝.糖豆゜", @"女", @"黑夜的眼睛"],
                   @[@"tx3.jpg", @"幸福加载中...", @"女", @"黑夜的眼睛"],
                   @[@"tx4.jpg", @"吃心不改", @"女", @"黑夜的眼睛"],
                   @[@"tx5.jpg", @"Mé、尐懒虫ゞ", @"女", @"黑夜的眼睛"],
                   @[@"tx6.jpg", @"水煮美人鱼罒3罒", @"女", @"黑夜的眼睛"],
                   @[@"tx7.jpg", @"柠萌￢ε￢", @"女", @"黑夜的眼睛"],
                   @[@"tx8.jpg", @"黑夜精灵", @"女", @"黑夜的眼睛"],

                   @[@"tx2.jpg", @"手心", @"女", @"寂寞让我如此美丽"]];
    
    _dataList = [[NSMutableArray alloc]init];
    for (int i=0; i<_dataArray.count; i++) {
        
       Member *model = [[Member alloc] initWithImage:_dataArray[i][0] Nc:_dataArray[i][1] Xb:_dataArray[i][2] Nl:_dataArray[i][3]];
       [_dataList addObject:model];
    }

 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _dataList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tzCell = @"MemberCellIdentifier";
    static BOOL isRegNib = NO;
    if (!isRegNib) {
        NSLog(@"isRegNib");
        [self.tableView registerNib:[UINib nibWithNibName:@"MembersCell" bundle:nil] forCellReuseIdentifier:tzCell];
        isRegNib = YES;
    }
    NSLog(@"THE INDEXPATH ROW IS %ld",indexPath.row);
    NSLog(@"THE DATA COUNT IS %ld", _dataList.count);
    MembersCell *cell = [self.tableView dequeueReusableCellWithIdentifier:tzCell];
    [cell setupCell:_dataList[indexPath.row]];
    
    if (cell == nil)
    {
//               cell = [[MembersCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tzCell];
        [self.tableView registerNib:[UINib nibWithNibName:@"MembersCell" bundle:nil] forCellReuseIdentifier:tzCell];
         MembersCell *cell1 = [self.tableView dequeueReusableCellWithIdentifier:tzCell];
        [cell1 setupCell:_dataList[indexPath.row]];
        cell = cell1;
        NSLog(@"CELL IS NIL ");
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88.0f;
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
