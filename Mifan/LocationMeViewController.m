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
@synthesize longitudeValue,latitudeValue, userModel;

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
    
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 60, 320, 508)];
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
    [self getUserAction];
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
    
    [_client uploadLocation:user.idString withBeizhu:self.placeValue withLongitude:self.longitudeValue withLatitude:self.latitudeValue];

//    NSLog(@"the long is %@, the lat is %@",self.longitudeValue, self.latitudeValue);
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
            
//            WaiqinHttpClient *client = [WaiqinHttpClient sharedWaiqinHttpClient];
//            client.delegate = self;
            
            
//            NSLog(@"the user name is %@", userModel.idString);
            
            //            NSLog(@"the long is %@, the lat is %@, the address is %@",self.longitudeValue, self.latitudeValue, self.placeValue);
            
            

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


- (void)getUserAction
{
    _wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"mango" accessGroup:nil];
    NSString *userName = [_wrapper objectForKey:(__bridge id)kSecAttrAccount];
    NSString *userPassword = [_wrapper objectForKey:(__bridge id)kSecValueData];
    
    _client = [WaiqinHttpClient sharedWaiqinHttpClient];
    const char *cStr = [userPassword UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    userPassword = [NSString stringWithFormat:
                    @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                    result[0], result[1], result[2], result[3],
                    result[4], result[5], result[6], result[7],
                    result[8], result[9], result[10], result[11],
                    result[12], result[13], result[14], result[15]
                    ];
    
    _client.delegate = self;
    [_client loginActionUser:userName withPassword:userPassword];
}



- (void)waiqinHTTPClient:(WaiqinHttpClient *)client didSignin:(id)responseData
{
    NSDictionary *res = [responseData objectForKey:@"wsr"];
    id statusID = [res objectForKey:@"status"];
    NSString *status = @"";
    
    if (statusID != [NSNull null]) {
        
        status = statusID;
        //NSLog(@"the respose data are %@", responseData);
        if ([status isEqualToString:@"1"]) {
            
            //NSLog(@"the respose data are %@", responseData);
            NSDictionary *dictionaryList;
            NSArray *arrayList = [res objectForKey:@"lists"];
            dictionaryList = [arrayList objectAtIndex: 0];
            user = [[User alloc] initWithImage:@"" name: [dictionaryList objectForKey:@"username"] pwd:[dictionaryList objectForKey:@"password"] group:[dictionaryList objectForKey:@"unitname"] idString:[dictionaryList objectForKey:@"id"]];
            
        }
    }
}


@end
