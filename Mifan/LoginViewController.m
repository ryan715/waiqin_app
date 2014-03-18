//
//  LoginViewController.m
//  Mifan
//
//  Created by ryan on 13-11-14.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

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
	self.textName.delegate = self;
    self.textPassword.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)Register:(id)sender
{
    [self performSegueWithIdentifier:@"toRegister" sender:self];

}


- (IBAction)Login:(id)sender
{
    NSString *UserName = self.textName.text;
    NSString *UserPassword = self.textPassword.text;
    
    [PFUser logInWithUsernameInBackground:UserName password:UserPassword block:^(PFUser *user, NSError *error) {
        if (user) {
             [self performSegueWithIdentifier:@"toMain" sender:self];
        }else{
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlertView show];
            
        }
    }];

}

- (void)backToLogin:(RegisterViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare for sege");
    if ([segue.identifier isEqualToString:@"toRegister"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        RegisterViewController *registerViewController = [[navigationController viewControllers] objectAtIndex:0];
        registerViewController.delegate = self;
    
    }
}


@end
