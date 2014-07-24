//
//  SidebarMenuViewController.m
//  Mifan
//
//  Created by ryan on 13-11-15.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "SidebarMenuViewController.h"
#import "VicinityViewController.h"
#import "SWRevealViewController.h"
#import "MainViewController.h"
#import "PictureListViewController.h"
#import "AboutViewController.h"
#import "MessagesTableViewController.h"

@interface SidebarMenuViewController ()

@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation SidebarMenuViewController

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

//    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
//    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    
    
   self.tableView.separatorColor = [UIColor clearColor];//[UIColor colorWithWhite:0.15f alpha:0.2f];
    
    _menuItems = @[@"title", @"profile", @"vicinity", @"picture", @"friends", @"messages", @"about"];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    if (indexPath.row == 0) {
//        
//    }
    switch (indexPath.row) {
        case 0:
            [self customTitle];
            [cell.contentView addSubview:self.sidebarTitleLabel];
            break;
          
        case 1:
            self.sidebarProfileLabel = [self customIndex: @"个人信息"];
            [cell.contentView addSubview:self.sidebarProfileLabel];
            break;
        case 2:
            self.sidebarVicinityLabel = [self customIndex: @"考勤定位"];
            [cell.contentView addSubview:self.sidebarVicinityLabel];
            break;

        case 3:
            self.sidebarMessagesLabel = [self customIndex: @"活动上报"];
            [cell.contentView addSubview:self.sidebarMessagesLabel];
            break;
        case 4:
            self.sidebarFriendsLabel = [self customIndex: @"我的群组"];
            [cell.contentView addSubview:self.sidebarFriendsLabel];
            break;
        case 5:
            self.sidebarMessagesLabel = [self customIndex: @"我的信息"];
            [cell.contentView addSubview:self.sidebarMessagesLabel];
            break;
        case 6:
            self.sidebarAboutLabel = [self customIndex: @"关于"];
            [cell.contentView addSubview:self.sidebarAboutLabel];
            break;

        default:
            break;
    }
    
//    cell.contentView.backgroundColor = [UIColor colorWithRed:(float)(219/255.0f) green:(float)(219/255.0f) blue:(float)(219/255.0f) alpha:1.0f];
    return cell;
}

- (void)customTitle
{
    UIColor *appColor = [UIColor colorWithRed:(float)(102/255.0f) green:(float)(205/255.0f) blue:(float)(204/255.0f) alpha:1.0f];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 150, 25)];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:20.0];
    titleLabel.text = @"芒果外勤";
    titleLabel.textColor = appColor;
//    titleLabel.backgroundColor = appColor;
    titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.sidebarTitleLabel = titleLabel;
}

- (UILabel *)customIndex: (NSString *)name
{
    UIColor *appColor = [UIColor colorWithRed:(float)(102/255.0f) green:(float)(205/255.0f) blue:(float)(204/255.0f) alpha:1.0f];
    UILabel *indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 100, 25)];
    indexLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:14.0];
    indexLabel.text = name;
    indexLabel.textColor = appColor;
    //    titleLabel.backgroundColor = appColor;
    indexLabel.lineBreakMode = NSLineBreakByCharWrapping;
    indexLabel.numberOfLines = 0;
    indexLabel.textAlignment = NSTextAlignmentLeft;
    
    return indexLabel;
//    self.sidebarProfileLabel = indexLabel;
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


- (void) prepareForSegue:(UIStoryboardSegue *) segue sender: (id) sender
{
   // NSLog(@"prepareForSegue");
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[_menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"toVicinity"]) {
        //NSLog(@"VicinityViewController");
        VicinityViewController *vicinityController = (VicinityViewController*)segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:@"toPicture"]) {
        //NSLog(@"VicinityViewController");
        PictureListViewController *pictureController = (PictureListViewController *)segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:@"toFriends"]) {
        NSLog(@"toMain");
        MainViewController *mainController = (MainViewController *)segue.destinationViewController;
        [segue destinationViewController];
    }
    
    if ([segue.identifier isEqualToString:@"toAboutView"]) {
        AboutViewController *aboutView = (AboutViewController *)segue.destinationViewController;
        [segue destinationViewController];
    }
    
    if ([segue.identifier isEqualToString:@"toMessages"]) {
        //NSLog(@"toProfile");
        MessagesTableViewController *messagesViewController = (MessagesTableViewController *)segue.destinationViewController;
        [segue destinationViewController];
    }


    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
         NSLog(@"SWRevealViewControllerSegue");
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
        
}

@end
