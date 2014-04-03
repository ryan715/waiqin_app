//
//  PictureNewViewController.m
//  Mifan
//
//  Created by ryan on 14-4-3.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "PictureNewViewController.h"
#import "UIPlaceHolderTextView.h"
#import "Photo.h"

@interface PictureNewViewController ()
{
    UITextView *textView;
}
@end

@implementation PictureNewViewController
@synthesize photoImage;

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
    [self customSet];
}

- (void)customSet
{
    textView.delegate = self;
    UIPlaceHolderTextView *placeTextView = [[UIPlaceHolderTextView alloc] init];
    placeTextView.placeholder = @"输入上报内容";
    placeTextView.frame = CGRectMake(20, 80, 300, 100);
    placeTextView.delegate = self;
    textView = placeTextView;
    
    [self.view addSubview: textView];
    
    
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 200, 300)];
    photoImageView.image = [self photoImage];
    
    [self.view addSubview:photoImageView];
    
    
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

- (IBAction)backAction:(id)sender
{
    [self.delegate toNewList:self];
}

- (IBAction)sentAction:(id)sender
{
    NSString *contentString = textView.text;
    NSString *photoString = [Photo image2String: photoImage];
    WaiqinHttpClient *client = [WaiqinHttpClient sharedWaiqinHttpClient];
    client.delegate = self;
    
    [client uploadImage:@"a005" withBeizhu:contentString withImage:photoString];
}

- (void)waiqinHTTPClient:(WaiqinHttpClient *)client uploadImage:(id)responseDate
{
    NSDictionary *ws = [responseDate objectForKey:@"wsr"];
    NSString *status = [ws objectForKey:@"status"];
    
    if ([status isEqualToString:@"1"]) {
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:@"上传成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [errorAlertView show];
    }else{
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:@"上传失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [errorAlertView show];
    }
}

@end
