//
//  PictureNewViewController.h
//  Mifan
//
//  Created by ryan on 14-4-3.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaiqinHttpClient.h"
#import "User.h"

@class PictureNewViewController;

@protocol PictureNewViewControllerDelegate <NSObject>

- (void)toNewList:(PictureNewViewController *)viewController;

@end


@interface PictureNewViewController : UIViewController<UITextViewDelegate, WaiqinHttpClientDelegate>
@property (nonatomic, strong) id<PictureNewViewControllerDelegate> delegate;
@property (nonatomic, weak) UIImage *photoImage;
@property   (weak, nonatomic) User *userModel;

- (IBAction)backAction:(id)sender;
- (IBAction)sentAction:(id)sender;
@end
