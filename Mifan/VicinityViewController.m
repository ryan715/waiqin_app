//
//  VicinityViewController.m
//  Mifan
//
//  Created by ryan on 13-12-6.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "VicinityViewController.h"
#import "SWRevealViewController.h"
#import "LocationMeViewController.h"
#import "LocationDetailViewController.h"
#import "Location.h"

@interface VicinityViewController ()
{
    NSMutableArray *itemList;
}

@end

@implementation VicinityViewController
@synthesize hud;
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
	_sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
   // _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    self.title = @"我的定位";
    [self customUIBarButtonItem];
    [self customeTableView];
    [self loadData];
    
    itemList = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customUIBarButtonItem
{
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"定位" style:UIBarButtonItemStylePlain target:self action:@selector(doToLocation:)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)doToLocation:(id)sender
{
     [self performSegueWithIdentifier:@"toLocation" sender:self];
}

/* 创建定位列表 */
- (void)customeTableView
{
    self.listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, 320, 528)];
    [self.listTable setDelegate:self];
    [self.listTable setDataSource:self];
    [self.view addSubview:self.listTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableViewCellIdentifier = @"TableViewCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
    }
    
    Location *locationModel = [itemList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = locationModel.beizhu;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    LocationDetailViewController *locationDetail = [[LocationDetailViewController alloc] init];
//    [self.navigationController pushViewController:locationDetail animated:YES];
//    
//    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
//    returnButtonItem.title = @"返回";
//    self.navigationItem.backBarButtonItem = returnButtonItem;

    [self performSegueWithIdentifier:@"toLocationDetail" sender:self];

    
}

- (void)loadData
{
    WaiqinHttpClient *client = [WaiqinHttpClient sharedWaiqinHttpClient];
    client.delegate = self;
    [client listLocationAction:@"32" withPageIndex:@"1" withPageSize:@"10"];

}


- (void)waiqinHTTPClient:(WaiqinHttpClient *)client listLocation:(id)responseData
{
    //NSLog(@"the list all is %@", responseData);
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    NSString *status = [res objectForKey:@"status"];
    
    //[self.hud hide:YES];
    if ([status isEqualToString:@"1"]) {
        NSDictionary *dictionaryList;
        NSArray *array = [res objectForKey:@"lists"];
        NSLog(@"the itemlist array size %f",array.count);

        for (int  i=0; i<array.count; i++) {
            dictionaryList = array[i];
            Location *location = [[Location alloc] initWithCustom:[dictionaryList objectForKey:@"beizhu"] UserId:[dictionaryList objectForKey:@"id"] Longitude:[dictionaryList objectForKey:@"longitude"] Latitude:[dictionaryList objectForKey:@"latitude"] Telephone:[dictionaryList objectForKey:@"telephone"] TrueName:[dictionaryList objectForKey:@"truename"]];
            NSLog(@"the beizhu is %@",[dictionaryList objectForKey:@"beizhu"]);
            [itemList addObject:location];
        }
        //NSLog(@"the itemlist count size %f",[itemList ]);
        [self.listTable reloadData];
    }
    else{
        NSString *errorString = [res objectForKey:@"message"];
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [errorAlertView show];
        
    }
    //    NSLog(@"THE status IS %@",status);
    //    id lists = [res objectForKey:@"lists"];
    //    NSArray *array = lists;
    //    NSDictionary *dic = [array objectAtIndex:0];
    //    //NSDictionary *list = [lists objectFromJSONData];
    //    NSString *department = [dic objectForKey:@"telephone"];
    ////    NSDictionary *lists = [res objectForKey:@"lists"];
    ////
    //  NSLog(@"THE department IS %@",department);
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navigationController = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"toLocation"]) {

        LocationMeViewController *locationMe = [[navigationController viewControllers] objectAtIndex:0];
        [locationMe setDelegate:self];
    }
    
    if ([segue.identifier isEqualToString:@"toLocationDetail"]) {
        LocationDetailViewController *detail = [[navigationController viewControllers] objectAtIndex:0];
        //LocationDetailViewController *detail = [segue destinationViewController];
        detail.delegate = self;
        detail.location = [itemList objectAtIndex:self.listTable.indexPathForSelectedRow.row];
        //NSLog(@"the select is %d", self.listTable.indexPathForSelectedRow);
    }
    
}

- (void)backToLocation:(LocationMeViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)DetailBackToLocation:(LocationDetailViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
