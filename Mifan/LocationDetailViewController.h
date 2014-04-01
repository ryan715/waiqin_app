//
//  LocationDetailViewController.h
//  Mifan
//
//  Created by ryan on 14-3-31.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import <MAMapKit/MAMapKit.h>

@class LocationDetailViewController;

@protocol LocationDetailViewControllerDelegate <NSObject>

- (void)DetailBackToLocation:(LocationDetailViewController *)viewController;

@end

@interface LocationDetailViewController : UIViewController<MAMapViewDelegate>


@property (nonatomic, weak) id<LocationDetailViewControllerDelegate>delegate;
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) MAMapView *mapView;
- (IBAction)backAction:(id)sender;

@end
