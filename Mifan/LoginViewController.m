//
//  LoginViewController.m
//  Mifan
//
//  Created by ryan on 13-11-14.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
//#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import <CommonCrypto/CommonDigest.h>
#import "MainViewController.h"
#import "forwadbackSegue.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UITextField *nameTextField;

//@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LoginViewController

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
//	self.textName.delegate = self;
//    self.textPassword.delegate = self;
    
    _wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"mango" accessGroup:nil];
    NSString *userName = [_wrapper objectForKey:(__bridge id)kSecAttrAccount];
    NSString *userPassword = [_wrapper objectForKey:(__bridge id)kSecValueData];    //    if (_user.nameString != nil && _user.passwordString != nil) {
//        NSString *userName = _user.nameString;
//        NSString *userPassword = _user.passwordString;
//    self.textName.text = userName;
//    self.textPassword.text = userPassword;

    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    UIBarButtonItem *loginButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleBordered target:self action:@selector(textFieldFinished:)];
    self.navigationItem.rightBarButtonItem = loginButtonItem;
    
    [self customController];
    [self customTextField: userName passwordString:userPassword];
}

- (void)customController
{
    UIImage *loginImage = [UIImage imageNamed:@"loginBg"];
    self.backgroundImageView = [[UIImageView alloc] initWithImage:loginImage];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    //    [self.view addSubview:self.backgroundImageView];
    
    //    CGRect loginImageFrame = CGRectMake(0, 60, loginImage.size.width, loginImage.size.height);
    //    self.backgroundImageView.frame = loginImageFrame;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style: UITableViewStyleGrouped];
    //    self.tableView.style = UITableViewStyleGrouped;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    CGRect headerFrame = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, loginImage.size.height+30);
    UIView *header = [[UIView alloc] initWithFrame:headerFrame];
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;
    
    [header addSubview:self.backgroundImageView];
    
    
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
//    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    self.activityIndicator.color = [UIColor grayColor];
//    self.barButton = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
//    
//    [[self navigationItem] setRightBarButtonItem:self.barButton];
}

- (void)customTextField: (NSString *)nameString passwordString: (NSString *)passwordString
{
    self.textFieldArrays = [[NSMutableArray alloc] initWithCapacity:2];
    
    for (int i = 0; i < 2; i++) {
        if (i == 0) {
            UITextField *nmeTextField = [[UITextField alloc] init];
            nmeTextField.frame = CGRectMake(20, 10, 300, 25);
            nmeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            nameTextField = nmeTextField;
            nmeTextField.placeholder = @"账号";
            [nmeTextField setLeftViewMode:UITextFieldViewModeAlways];
            nmeTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"name"]];
            nmeTextField.delegate = self;
            nmeTextField.text = nameString;
            [nameTextField addTarget:self action:@selector(closeKeyBoard:) forControlEvents:UIControlEventEditingDidEndOnExit];
            [self.textFieldArrays addObject:nmeTextField];
            
        } else {
            UITextField *pswTextField = [[UITextField alloc] init];
            pswTextField.frame = CGRectMake(20, 10, 300, 25);
            pswTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            passwordTextField = pswTextField;
            pswTextField.placeholder = @"密码";
            
            [pswTextField setLeftViewMode:UITextFieldViewModeAlways];
            pswTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
            pswTextField.text = passwordString;
            pswTextField.delegate =self;
            pswTextField.secureTextEntry = YES;
            [pswTextField setReturnKeyType:UIReturnKeyDone];
            [passwordTextField addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
            //            UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
            //            [iconView setContentMode:UIViewContentModeBottomLeft];
            //            iconView.frame =CGRectMake(0, 0, 40, 25);
            //            [pswTextField addSubview:iconView];
            [self.textFieldArrays addObject:pswTextField];
            
        }
    }
}

- (IBAction)textFieldFinished:(id)sender
{
    NSLog(@"text field finish");
    [self.activityIndicator startAnimating];
    
//    [TSMessage showNotificationWithTitle:@"Error" subtitle:@"账号或者密码错误" type:TSMessageNotificationTypeError];
    
    [self.activityIndicator stopAnimating];
    
    [self LoginAction];
    //[self performSegueWithIdentifier:@"toMain" sender:self];
}

- (IBAction)closeKeyBoard:(id)sender
{
    [nameTextField resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [nameTextField becomeFirstResponder];
}


- (void)viewTapped:(UITapGestureRecognizer *)tapGr
{
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    int row = indexPath.row;
    NSLog(@"THE ROW IS %d", row);
    [cell.contentView addSubview:[self.textFieldArrays objectAtIndex:row]];
    return cell;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    self.tableView.frame = bounds;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectiontable
{
    return 100.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}




- (void)LoginAction
{
    NSString *UserName = nameTextField.text;
    NSString *UserPassword = passwordTextField.text;
    
    
    if ([self NameBlankString:UserName PasswordBlankString:UserPassword]){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"芒果外勤"
                                                     message:[NSString stringWithFormat:@"%@",@"用户名或者密码错误"]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];

    }
    else {
        
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeIndeterminate;
        [self.hud show:YES];
        
        
      
//    NSString *UserName = @"a005";
//    NSString *UserPassword = @"1";
    
        
        _user = [[User alloc] initWithImage:@"" name:UserName pwd:UserPassword group:@"" idString:@""];
        
        
           /********* md5 crypto ***********/
    
    const char *cStr = [UserPassword UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    UserPassword = [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
    
    /********* end  md5 crypto ***********/
//
//    [PFUser logInWithUsernameInBackground:UserName password:UserPassword block:^(PFUser *user, NSError *error) {
//        if (user) {
//             [self performSegueWithIdentifier:@"toMain" sender:self];
//        }else{
//            NSString *errorString = [[error userInfo] objectForKey:@"error"];
//            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [errorAlertView show];
//            
//        }
//    }];
    NSLog(@"begin");
    WaiqinHttpClient *client = [WaiqinHttpClient sharedWaiqinHttpClient];
    client.delegate = self;
        
        if (![client isConnectionAvailable]) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.removeFromSuperViewOnHide =YES;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = NSLocalizedString(@"网络链接失败", nil);
            hud.minSize = CGSizeMake(132.f, 108.0f);
            [hud hide:YES afterDelay:3];
            
            [self.hud hide:YES];
           
        } else {
            [client loginActionUser:UserName withPassword:UserPassword];
   
//        [hud hide:YES];
        }
    }
}

- (void)waiqinHTTPClient:(WaiqinHttpClient *)client didSignin:(id)user
{
    //waiqinHTTPClient
    NSDictionary *res = [user objectForKey:@"wsr"];
//    NSString *status = [res objectForKey:@"status"];
    
    [self.hud hide:YES];
    id statusID = [res objectForKey:@"status"];
    NSString *status = @"";
    
    if (statusID != [NSNull null]) {
        
        status = statusID;

        if ([status isEqualToString:@"1"]) {
        
            [_wrapper setObject:_user.nameString forKey:(__bridge id)kSecAttrAccount];
            [_wrapper setObject:_user.passwordString forKey:(__bridge id)kSecValueData];
        
            [self performSegueWithIdentifier:@"toMain" sender:self];
        }
        else{
            NSString *errorString = [res objectForKey:@"message"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                   [errorAlertView show];

        }
    }else{
        NSString *errorString = [res objectForKey:@"message"];
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:@"服务端没有响应" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

-(void)waiqinHTTPClient:(WaiqinHttpClient *)client didFailWithError:(NSError *)error
{
    [self.hud hide:YES];
    NSString *errorString = error;
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:@"服务端没有响应" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [errorAlertView show];

}


- (void)backToLogin:(RegisterViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSLog(@"prepare for sege");
////    if ([segue.identifier isEqualToString:@"toRegister"])
////    {
////        UINavigationController *navigationController = segue.destinationViewController;
////        RegisterViewController *registerViewController = [[navigationController viewControllers] objectAtIndex:0];
////        registerViewController.delegate = self;
////    
////    }
//    
//    
//    forwadbackSegue *s = (forwadbackSegue *)segue;
//    
//    if ([segue.identifier isEqualToString:@"toRegister"]) {
//        s.isDismiss = NO;
//        NSLog(@"the isdismiss NO");
//        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
//        {
//            s.isLandscapeOrientation = YES;
//        }
//        else
//        {
//            s.isLandscapeOrientation = NO;
//        }
//
//    }else if ([segue.identifier isEqualToString:@"backwardSegue"]){
//        s.isDismiss = YES;
//        NSLog(@"the isdismiss NO");
//        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
//        {
//            s.isLandscapeOrientation = YES;
//        }
//        else
//        {
//            s.isLandscapeOrientation = NO;
//        }
//
//    }
//    
//
//    
////    if ([segue.identifier isEqualToString:@"toMain"])
////    {
////        UINavigationController *navigationController = segue.destinationViewController;
////        MainViewController *mainViewController = [[navigationController viewControllers] objectAtIndex:0];
////        mainViewController.user = _user;
////        
////    }
//    
//}

-(BOOL) NameBlankString:(NSString *)StrUsername PasswordBlankString:(NSString *)StrPassword
{
    
    if (StrUsername == nil || StrPassword == nil) {
        return YES;
    }
    if (StrUsername == NULL || StrPassword == NULL) {
        return YES;
    }
    if ([StrUsername isKindOfClass:[NSNull class]] || [StrPassword isKindOfClass:[NSNull class]] ) {
        return YES;
    }
    if ([[StrUsername stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [[StrPassword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//-(void)viewTapped:(UITapGestureRecognizer*)tapGr
//{
//    [self.textName resignFirstResponder];
//    [self.textPassword resignFirstResponder];
//}




-(void)textFieldDidBeginEditing:(UITextField *)textField
{
        float  offset = -40.0f; //view向上移动的距离
         NSTimeInterval animationDuration = 0.30f;
         [UIView beginAnimations:@"ResizeForKeyBoard"context:nil];
         [UIView setAnimationDuration:animationDuration];
         float width = self.view.frame.size.width;
         float height = self.view.frame.size.height;
         CGRect rect = CGRectMake(0.0f, offset , width, height);
         self.view.frame = rect;
         [UIView  commitAnimations];
}



-(void)textFieldDidEndEditing:(UITextField *)textField
{
         float offset = 0.0f ;
         NSTimeInterval animationDuration = 0.30f;
         [UIView beginAnimations:@"ResizeForKeyBoard"context:nil];
         [UIView setAnimationDuration:animationDuration];
         float width = self.view.frame.size.width;
         float height = self.view.frame.size.height;
         CGRect rect = CGRectMake(0.0f, offset , width, height);
         self.view.frame = rect;
         [UIView commitAnimations];
}



@end
