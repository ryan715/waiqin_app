//
//  RegisterViewController.m
//  Mifan
//
//  Created by ryan on 13-11-14.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "RegisterViewController.h"
//#import <Parse/Parse.h>
#import "forwadbackSegue.h"
#import "MBProgressHUD.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
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
    self.title = @"";
    _wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"mango" accessGroup:nil];
    
//    self.textName.delegate = self;
//    self.textPassword.delegate = self;
//    self.ConfirmPasswordText.delegate = self;
//	// Do any additional setup after loading the view.
    
    /* 点击空白 隐藏键盘 */
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    [self customController];
}

- (void)customController
{
    UIImage *registerImage = [UIImage imageNamed:@"register"];
    self.titleImageView = [[UIImageView alloc]initWithImage:registerImage];
    self.titleImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview: self.tableView];
    
    CGRect headerFrame = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, registerImage.size.height);
    
    UIView *header = [[UIView alloc] initWithFrame:headerFrame];
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;
    
    [header addSubview: self.titleImageView];
    [self customTextField];
    
    
    UIBarButtonItem *registerBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleBordered target:self action:@selector(textFieldFinished:)];
    self.navigationItem.rightBarButtonItem = registerBarButtonItem;
}

- (void)customTextField
{
    self.textFieldArrays = [[NSMutableArray alloc] initWithCapacity:3];
    for (int i= 0; i< 3; i++) {
        if (i == 0) {
            UITextField *nameTextField = [[UITextField alloc] init];
            nameTextField.frame = CGRectMake(20, 10, 300, 25);
            nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            nameTextField.placeholder = @"账号";
            [nameTextField setLeftViewMode:UITextFieldViewModeAlways];
            nameTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"name"]];
            nameTextField.delegate = self;
            [nameTextField addTarget:self action:@selector(closeKeyBoard:) forControlEvents:UIControlEventEditingDidEndOnExit];
            accountTextField = nameTextField;
            [self.textFieldArrays addObject:nameTextField];
        } else if(i == 1) {
            
            UITextField *pswTextField = [[UITextField alloc] init];
            pswTextField.frame = CGRectMake(20, 10, 300, 25);
             passwordTextField = pswTextField;
            pswTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            pswTextField.placeholder = @"密码";
            [pswTextField setLeftViewMode:UITextFieldViewModeAlways];
            pswTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"name"]];
            pswTextField.delegate = self;
            pswTextField.secureTextEntry = TRUE;
            [pswTextField addTarget:self action:@selector(closeKeyBoard:) forControlEvents:UIControlEventEditingDidEndOnExit];
           
            [self.textFieldArrays addObject:pswTextField];
        } else {
            UITextField *cpswTextField = [[UITextField alloc] init];
            cpswTextField.frame = CGRectMake(20, 10, 300, 25);
            
            conPasswordTextField = cpswTextField;
            cpswTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            cpswTextField.placeholder = @"确认密码";
            cpswTextField.secureTextEntry = TRUE;
            [cpswTextField setLeftViewMode:UITextFieldViewModeAlways];
            cpswTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"name"]];
            cpswTextField.delegate = self;
//            [cpswTextField addTarget:self action:@selector(closeKeyBoard:) forControlEvents:UIControlEventEditingDidEndOnExit];
            [cpswTextField setReturnKeyType:UIReturnKeyDone];
            [cpswTextField addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
            
            [self.textFieldArrays addObject:cpswTextField];
            
        }
        
        
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RegisterCellIdentifier = @"RegisterCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RegisterCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RegisterCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:[self.textFieldArrays objectAtIndex:indexPath.row]];
    return cell;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    self.tableView.frame = bounds;
}


- (IBAction)closeKeyBoard:(id)sender
{
    [accountTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}



- (void)viewDidAppear:(BOOL)animated
{
    [accountTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)LoginButton:(id)sender
//{
//    NSLog(@"LOGIN BUTTON");
//    [self.delegate backToLogin:self];
//}

- (void)RegisterAction
{

    
    NSString *UserName = accountTextField.text;
    NSString *UserPassword = passwordTextField.text;
    NSString *CUserPassword = conPasswordTextField.text;
    
    if ([self NameBlankString:UserName PasswordBlankString:UserPassword]){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"芒果外勤"
                                                     message:[NSString stringWithFormat:@"%@",@"用户名或者密码不能为空"]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
        
    } else if( ![UserPassword isEqualToString:CUserPassword]){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"芒果外勤"
                                                     message:[NSString stringWithFormat:@"%@",@"密码不一致"]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }else {
        
//        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        self.hud.mode = MBProgressHUDModeIndeterminate;
//        [self.hud show:YES];

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
    WaiqinHttpClient *client = [WaiqinHttpClient sharedWaiqinHttpClient];
    client.delegate = self;
    
    if (![client isConnectionAvailable]) {
        
        MBProgressHUD *connectHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        connectHud.removeFromSuperViewOnHide =YES;
        connectHud.mode = MBProgressHUDModeText;
        connectHud.labelText = NSLocalizedString(@"网络链接失败", nil);
        connectHud.minSize = CGSizeMake(132.f, 108.0f);
        [connectHud hide:YES afterDelay:3];
        
        [connectHud hide:YES];
        
    } else {
        [client registerAction:UserName Password:UserPassword TrueName:@"" Email:@"" Telephone:@""];
        
        //        [hud hide:YES];
        }
    }

}


- (void)waiqinHTTPClient:(WaiqinHttpClient *)client registerDelegate:(id)responseData
{
    //waiqinHTTPClient
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    NSString *status = [res objectForKey:@"status"];
    NSLog(@"click register");
//    [self.hud hide:YES];
    if ([status isEqualToString:@"1"]) {
        
        UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:@"注册成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [successAlertView show];
       [self performSegueWithIdentifier:@"Signup" sender:self];
        
        [_wrapper setObject: accountTextField.text forKey:(__bridge id)kSecAttrAccount];
        [_wrapper setObject: passwordTextField.text forKey:(__bridge id)kSecValueData];
        
    }
    else{
        NSString *errorString = [res objectForKey:@"message"];
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [errorAlertView show];
        
    }
}

- (IBAction)textFieldFinished:(id)sender
{
    NSLog(@"text field finish");
//    [self.activityIndicator startAnimating];
    
//    [TSMessage showNotificationWithTitle:@"Error" subtitle:@"账号或者密码错误" type:TSMessageNotificationTypeError];
    
//    [self.activityIndicator stopAnimating];
    
    [self RegisterAction];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSLog(@"prepare for sege");
//    forwadbackSegue *s = (forwadbackSegue *)segue;
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
//    }else if ([segue.identifier isEqualToString:@"toLogin"]){
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

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    float offset = -80.0f;
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
//    CGRect rect = CGRectMake(0.0f, offset, width, height);
//    self.view.frame = rect;
//    [UIView commitAnimations];
//
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    float offset = 0.0f;
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
//    CGRect rect = CGRectMake(0.0f, offset, width, height);
//    self.view.frame = rect;
//    [UIView commitAnimations];
//    
//    
//}



-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
//    [self.textName resignFirstResponder];
//    [self.textPassword resignFirstResponder];
//    [self.ConfirmPasswordText resignFirstResponder];
}



@end
