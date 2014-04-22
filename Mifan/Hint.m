//
//  Hint.m
//  Image
//
//  Created by LYZ on 14-1-14.
//  Copyright (c) 2014年 LYZ. All rights reserved.
//

#import "Hint.h"
#import "ClickImage.h"
@interface Hint ()

@end

@implementation Hint

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dis:(id)sender {
    NSLog(@"!!!!");
    [ClickImage dismissClickView];
}

//- (IBAction)snap:(id)sender {
//    UIView *snapView = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    if(UIGraphicsBeginImageContextWithOptions != NULL)
//    {
//        UIGraphicsBeginImageContextWithOptions(snapView.frame.size, NO, 0.0);
//    } else {
//        UIGraphicsBeginImageContext(snapView.frame.size);
//    }
//    //获取图像
//    [snapView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    //保存图像
//    if (image!=nil) {
//        UIImageView *snapIt = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 160, 284)];
//        snapIt.image = image;
//        [self.view addSubview:snapIt];
//    }
//    else {
//        NSLog(@"Failed!");
//    }
//}
@end

