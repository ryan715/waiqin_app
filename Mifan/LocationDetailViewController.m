//
//  LocationDetailViewController.m
//  Mifan
//
//  Created by ryan on 14-3-31.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "LocationDetailViewController.h"

enum {
    AnnotationViewControllerAnnotationTypeRed = 0,
    AnnotationViewControllerAnnotationTypeGreen,
    AnnotationViewControllerAnnotationTypePurple
};
@interface LocationDetailViewController ()
@property (nonatomic, strong) NSMutableArray *annotations;
//@property (nonatomic, strong) GeoPoint *point;
@end

@implementation LocationDetailViewController

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
    //NSLog(@"i am her %@",self.location.beizhu);
    [self customMap];
    self.title = @"定位信息";
    
     [self initAnnotations];
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

- (void)customMap
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 60, 320, 508)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake([self.location.latitude floatValue], [self.location.longitude floatValue]);
    //center
    self.mapView.centerCoordinate = coords;
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.pinColor                     = [self.annotations indexOfObject:annotation];
        
        return annotationView;
    }
    
    return nil;
}

- (void)initAnnotations
{
    self.annotations = [NSMutableArray array];
    
    /* Red annotation. */
    MAPointAnnotation *red = [[MAPointAnnotation alloc] init];
    red.coordinate = CLLocationCoordinate2DMake([self.location.latitude floatValue], [self.location.longitude floatValue]);
    red.title      = @"Red";
    [self.annotations insertObject:red atIndex:AnnotationViewControllerAnnotationTypeRed];
    
    NSLog(@"the lat ist %@, the long is %@",self.location.latitude, self.location.longitude);
    
//    /* Green annotation. */
//    MAPointAnnotation *green = [[MAPointAnnotation alloc] init];
//    green.coordinate = CLLocationCoordinate2DMake(39.909698, 116.296248);
//    green.title      = @"Green";
//    [self.annotations insertObject:green atIndex:AnnotationViewControllerAnnotationTypeGreen];
//    
//    /* Purple annotation. */
//    MAPointAnnotation *purple = [[MAPointAnnotation alloc] init];
//    purple.coordinate = CLLocationCoordinate2DMake(40.045837, 116.460577);
//    purple.title      = @"Purple";
//    [self.annotations insertObject:purple atIndex:AnnotationViewControllerAnnotationTypePurple];
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"view :%@", view);
}


- (IBAction)backAction:(id)sender
{
    [self.delegate DetailBackToLocation:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mapView addAnnotations:self.annotations];
}

@end
