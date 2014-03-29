//
//  RegisterViewController.m
//  Mifan
//
//  Created by ryan on 13-11-14.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "RegisterViewController.h"
//#import <Parse/Parse.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    self.textName.delegate = self;
    self.textPassword.delegate = self;
    self.ConfirmPasswordText.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginButton:(id)sender
{
    NSLog(@"LOGIN BUTTON");
    [self.delegate backToLogin:self];
}

- (IBAction)RegisterButton:(id)sender
{
//    PFUser *user = [PFUser user];
//    
//    user.username = self.textName.text;
//    user.password = self.textPassword.text;
//    
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            [self performSegueWithIdentifier:@"Signup" sender:self ];
//        }else{
//            NSString *errorString = [[error userInfo] objectForKey:@"error"];
//            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [errorAlertView show];
//        }
//    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
