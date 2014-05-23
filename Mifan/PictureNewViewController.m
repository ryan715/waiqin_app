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

/* 自定义输入文本框 */
- (void)customSet
{
    textView.delegate = self;
    UIPlaceHolderTextView *placeTextView = [[UIPlaceHolderTextView alloc] init];
    placeTextView.placeholder = @"输入上报内容";
    placeTextView.frame = CGRectMake(20, 80, 280, 100);
    [placeTextView setFont: [UIFont fontWithName:@"Arial" size:18]];
    placeTextView.delegate = self;
    textView = placeTextView;
    [self.view addSubview: textView];
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 200, 300)];
    photoImageView.image = [self photoImage];
    [self.view addSubview:photoImageView];
}



/* 点击空白 隐藏键盘 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [textView resignFirstResponder];
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
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.hud show:YES];

    NSString *contentString = textView.text;
    NSString *photoString = [Photo image2String: photoImage];
    WaiqinHttpClient *client = [WaiqinHttpClient sharedWaiqinHttpClient];
    client.delegate = self;
//    NSLog(@"the upload user is %@", _userModel.nameString);
    
    [client uploadImage:_userModel.nameString withBeizhu:contentString withImage:photoString];
}

- (void)waiqinHTTPClient:(WaiqinHttpClient *)client uploadImage:(id)responseDate
{
    [self.hud hide:YES];
    
    
    [self.delegate toNewList:self];
    
    NSDictionary *ws = [responseDate objectForKey:@"wsr"];
    NSString *status = [ws objectForKey:@"status"];
    NSString *errMessage = [ws objectForKey:@"message"];
    if ([status isEqualToString:@"1"]) {
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:@"上传成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [errorAlertView show];
    }else{
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message: errMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [errorAlertView show];
    }
}

- (void)waiqinHTTPClient:(WaiqinHttpClient *)client didFailWithError:(NSError *)error
{
    [self.hud hide:YES];
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message: @"数据异常，请重试" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [errorAlertView show];

}

@end
