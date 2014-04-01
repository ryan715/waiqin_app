//
//  LocationMeViewController.m
//
//
//  Created by ryan on 14-3-28.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "LocationMeViewController.h"

@interface LocationMeViewController ()

@end

@implementation LocationMeViewController

CLLocationManager *locationManager;
CLGeocoder *geocoder;
CLPlacemark *placemark;
@synthesize longitudeValue,latitudeValue;

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
    // Do any additional setup after loading the view.
    
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 60, 320, 518)];
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
}

- (IBAction)uploadButtonClick:(id)sender
{
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
   
    NSLog(@"the long is %@, the lat is %@",self.longitudeValue, self.latitudeValue);
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}


    
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        self.longitudeValue = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.latitudeValue = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            self.placeValue = [NSString stringWithFormat:@"%@%@%@%@%@",
                                      placemark.subThoroughfare, placemark.thoroughfare,
                                      placemark.locality,
                                      placemark.administrativeArea,
                                      placemark.country];
            
            WaiqinHttpClient *client = [WaiqinHttpClient sharedWaiqinHttpClient];
            client.delegate = self;
            [client uploadLocation:@"a006" withBeizhu:self.placeValue withLongitude:self.longitudeValue withLatitude:self.latitudeValue];
            NSLog(@"the long is %@, the lat is %@, the address is %@",self.longitudeValue, self.latitudeValue, self.placeValue);
            
            

        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
       [locationManager stopUpdatingLocation];
}


- (void)waiqinHTTPClient:(WaiqinHttpClient *)client uploadLocation:(id)response
{
    //waiqinHTTPClient
    NSDictionary *res = [response objectForKey:@"wsr"];
    NSString *status = [res objectForKey:@"status"];
    if ([status isEqualToString:@"1"]) {
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:@"操作成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [errorAlertView show];
    }
    else{
        NSString *errorString = [res objectForKey:@"message"];
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"芒果外勤" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [errorAlertView show];
        
    }
}



- (IBAction)backAction:(id)sender
{
    [self.delegate backToLocation:self];
}


@end
