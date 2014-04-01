//
//  LocationMeViewController.h
//  Mifan
//
//  Created by ryan on 14-3-28.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WaiqinHttpClient.h"

@class LocationMeViewController;

@protocol LocationMeViewControllerDelegate <NSObject>

- (void)backToLocation:(LocationMeViewController *)viewController;

@end

@interface LocationMeViewController : UIViewController<MAMapViewDelegate, CLLocationManagerDelegate, WaiqinHttpClientDelegate>

@property (nonatomic, retain) NSString *longitudeValue;
@property (nonatomic, retain) NSString *latitudeValue;
@property (nonatomic, retain) NSString *placeValue;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, weak) id<LocationMeViewControllerDelegate>delegate;
- (IBAction)uploadButtonClick:(id)sender;
- (IBAction)backAction:(id)sender;

@end
