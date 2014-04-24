//
//  GroupOperationTableViewController.m
//  Mifan
//
//  Created by ryan on 14-4-24.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "GroupOperationTableViewController.h"

@interface GroupOperationTableViewController ()

@end

@implementation GroupOperationTableViewController

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
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                             reuseIdentifier: SimpleTableIdentifier];
        //设定附加视图
//                 [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
         //        UITableViewCellAccessoryNone,                   // 没有标示
        [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];   // 下一层标示
         //        UITableViewCellAccessoryDetailDisclosureButton, // 详情button
        //        UITableViewCellAccessoryCheckmark               // 勾选标记
        
              //设定选中cell时的cell的背影颜色
                 cell.selectionStyle=UITableViewCellSelectionStyleBlue;     //选中时蓝色效果
         //        cell.selectionStyle=UITableViewCellSelectionStyleNone; //选中时没有颜色效果
         //        cell.selectionStyle=UITableViewCellSelectionStyleGray;  //选中时灰色效果
         //
         //        //自定义选中cell时的背景颜色
         //        UIView *selectedView = [[UIView alloc] initWithFrame:cell.contentView.frame];
         //        selectedView.backgroundColor = [UIColor orangeColor];
         //        cell.selectedBackgroundView = selectedView;
    //        [selectedView release];
        
                 //        cell.selectionStyle=UITableViewCellAccessoryNone; //行不能被选中
        
             }
    
         //这是设置没选中之前的背景颜色
         cell.contentView.backgroundColor = [UIColor clearColor];
//         cell.imageView.image=[UIImage imageNamed:@"1001.jpg"];//未选cell时的图片
//         cell.imageView.highlightedImage=[UIImage imageNamed:@"1002.jpg"];//选中cell后的图片
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"加入群组";
            break;
        case 1:
            cell.textLabel.text = @"创建群组";
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"toGroupJoin" sender:self];
            
            break;
        case 1:
            [self performSegueWithIdentifier:@"toGroupNew" sender:self];

            break;
        default:
            break;
    }
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"toGroupNew"]) {
//        UINavigationController *navigationController = segue.destinationViewController;
        GroupNewTableViewController *newView = segue.destinationViewController;
        newView.delegate = self;
    }
}

- (void)newToListDelegate:(GroupNewTableViewController *)view
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
