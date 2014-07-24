//
//  AppDelegate.m
//  Mifan
//
//  Created by ryan on 13-11-14.
//  Copyright (c) 2013年 ryan. All rights reserved.
//

#import "AppDelegate.h"
#import <MAMapKit/MAMapKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    [Parse setApplicationId:@"YceEZkXoJF1Y9YkdqwQISU7gQhsCS8aUSwElRBha" clientKey:@"08oxkbxsM8SuhlUOydzVUXoBZBSsCIwboOjzMKSA"];
    
    [MAMapServices sharedServices].apiKey = @"2607dc3e66c4ae002aa4f21dce40053c";
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    UIColor *backColor = [UIColor colorWithRed:(float)(101/255.0f) green:(float)(101/255.0f) blue:(float)(101/255.0f) alpha:1.0f];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    
//    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:backColor, NSForegroundColorAttributeName, shadow, NSShadowAttributeName, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size: 18.0], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setTintColor:backColor];
    
    
    launchView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 460.0)];
    [launchView setImage:[UIImage imageNamed:@"Default.png"]];
     [self performSelector:@selector(removeLauchView) withObject:nil afterDelay:3.0];
    return YES;
}

- (void)removeLauchView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDidStopSelector:@selector(RemoveView)];
    launchView.alpha = 0;
    [UIView commitAnimations];
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
