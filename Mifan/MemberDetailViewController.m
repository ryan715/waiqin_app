//
//  MemberDetailViewController.m
//  Mifan
//
//  Created by ryan on 14-4-8.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "MemberDetailViewController.h"
#import "ImageHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MemberDetailViewController ()

@end

@implementation MemberDetailViewController
@synthesize model,listTable;
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
//    NSLog(@"the user id is %@",model.memberNl);
    
//    UIImage *profileImage = [UIImage imageNamed:@"tx1.jpg"];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.hud show:YES];
    

    
//    UIImage *profileImage = [[UIImage alloc] initWithData:[ NSData dataWithContentsOfURL:[NSURL URLWithString:model.memberImage]]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 100, 100)];
    [imageView setImageWithURL:[NSURL URLWithString: model.memberImage]];
    
    imageView.layer.cornerRadius = imageView.frame.size.width /2;
    imageView.clipsToBounds = YES;
    
//    ImageHelper *imageHelper = [[ImageHelper alloc] init];
//    imageView.image  = [imageHelper ellipseImage:profileImage withInset:0.0];
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(150, 80, 100, 100)];
    lblName.text = model.memberNc;
    lblName.font = [UIFont fontWithName:@"Arial" size:18.0];
    
    UILabel *lblGroup = [[UILabel alloc] initWithFrame:CGRectMake(150, 120, 200, 100)];
    lblGroup.text = [NSString stringWithFormat:@"%@ %@",model.memberNl, model.memberXb];
    lblGroup.font = [UIFont fontWithName:@"Arial" size:14.0];
    lblGroup.textColor = [UIColor grayColor];
    
    [self.view addSubview:imageView];
    [self.view addSubview:lblName];
    [self.view addSubview:lblGroup];
    [self customeTableView];
    
    [self.hud hide:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


/* 创建定位列表 */
- (void)customeTableView
{
    self.listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, 320, 500) style:UITableViewStyleGrouped ];
    
    //self.listTable =
    [self.listTable setDelegate:self];
    [self.listTable setDataSource:self];
    [self.view addSubview:self.listTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
    
    //Location *locationModel = [itemList objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"电话号码: %@", model.telephoneString];
    } else if(indexPath.row == 1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"email: %@", model.emailString];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
