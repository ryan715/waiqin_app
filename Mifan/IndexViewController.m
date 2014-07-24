//
//  IndexViewController.m
//  Mifan
//
//  Created by ryan on 14-6-4.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "IndexViewController.h"
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"


@interface IndexViewController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) FUIButton *submitButton;
@property (nonatomic, strong) FUIButton *registerButton;
@end

@implementation IndexViewController

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
    self.title = @"欢迎";
    UIImage *background = [UIImage imageNamed:@"bg"];
    self.backgroundImageView = [[UIImageView alloc] initWithImage:background];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    // Do any additional setup after loading the view.
    
    [self customController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)customController {
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    NSLog(@"the screen width is %f, height is %f", screenWidth, screenHeight);
    
    CGFloat buttonHieght = 350.0f;
    if (screenHeight > 480) {
        buttonHieght = 450.0f;
    }
    
    self.submitButton = [[FUIButton alloc]init];
    CGRect buttonFrame = CGRectMake(20, buttonHieght, 320-20*2, 40);
    self.submitButton.frame = buttonFrame;
    self.submitButton.buttonColor = [UIColor wetAsphaltColor];
    //    self.submitButton.shadowColor = [UIColor greenSeaColor];
    //    self.submitButton.shadowHeight = 3.0f;
    self.submitButton.cornerRadius = 0.0f;
    self.submitButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.submitButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.submitButton setTitle:@"登  录" forState:UIControlStateNormal];
    
    [self.submitButton addTarget:self action:@selector(toLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.submitButton];
    
    self.registerButton = [[FUIButton alloc]init];
    self.registerButton = [FUIButton buttonWithType:UIButtonTypeCustom];
    //    CGRect regitsterFrame = CGRectMake(20, 450, 320-20*2, 40);
    CGRect regitsterFrame = CGRectMake(20, buttonHieght+ 50, 320-20*2, 40);
    self.registerButton.backgroundColor = [UIColor clearColor];
    self.registerButton.frame = regitsterFrame;
    self.registerButton.buttonColor = [UIColor sunflowerColor];
    //    self.registerButton.shadowColor = [UIColor greenSeaColor];
    //    self.registerButton.shadowHeight = 3.0f;
    self.registerButton.cornerRadius = 0.0f;
    self.registerButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.registerButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.registerButton setTitle:@"注  册 " forState:UIControlStateNormal];
    //    self.registerButton.alpha = 0.7;
    
    [self.registerButton addTarget:self action:@selector(toRegisterClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerButton];
    
    
    
    //    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:0.841 green:0.566 blue:0.566 alpha:1.0].CGColor, (id)[UIColor colorWithRed:0.75 green:0.341 blue:0.345 alpha:1.0].CGColor, (id)[UIColor colorWithRed:0.592 green:0.0 blue:0.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:0.592 green:0.0 blue:0.0 alpha:1.0].CGColor, nil]];
    //    UIButton *tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    tmpBtn.frame = CGRectMake(20, 50, 100, 100);
    //    [tmpBtn setTitle:@"选择地图" forState:UIControlStateNormal];
    //    [tmpBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //    tmpBtn.backgroundColor=[UIColor clearColor];
    //    [self.view addSubview:tmpBtn];
    
}



- (IBAction)toRegisterClick:(id)sender
{
    [self performSegueWithIdentifier:@"toRegister" sender:self];
}

- (IBAction)toLoginClick:(id)sender
{
    [self performSegueWithIdentifier:@"toLogin" sender:self];
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

@end
