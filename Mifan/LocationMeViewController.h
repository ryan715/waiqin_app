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

@interface LocationMeViewController : UIViewController<MAMapViewDelegate, CLLocationManagerDelegate, WaiqinHttpClientDelegate>

@property (nonatomic, retain) NSString *longitudeValue;
@property (nonatomic, retain) NSString *latitudeValue;
@property (nonatomic, retain) NSString *placeValue;
@property (nonatomic, strong) MAMapView *mapView;

- (IBAction)uploadButtonClick:(id)sender;
@end
