//  Created by Phillipus on 19/09/2013.
//  Copyright (c) 2013 Dada Beatnik. All rights reserved.
//

#import "CustomSegue.h"

@implementation CustomSegue
@synthesize isDismiss,isLandscapeOrientation;

- (void)perform {
//    UIViewController *sourceViewController = self.sourceViewController;
//    UIViewController *destinationViewController = self.destinationViewController;
//    
//    // Add the destination view as a subview, temporarily
//    [sourceViewController.view addSubview:destinationViewController.view];
//    
//    // Transformation start scale
//    destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
//    
//    // Store original centre point of the destination view
//    CGPoint originalCenter = destinationViewController.view.center;
//    // Set center to start point of the button
//    destinationViewController.view.center = self.originatingPoint;
//    
//    [UIView animateWithDuration:0.5
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         // Grow!
//                         destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
//                         destinationViewController.view.center = originalCenter;
//                     }
//                     completion:^(BOOL finished){
//                         [destinationViewController.view removeFromSuperview]; // remove from temp super view
//                         [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL]; // present VC
//                     }];


    UIViewController *desViewController = (UIViewController *)self.destinationViewController;
    
    	    UIView *srcView = [(UIViewController *)self.sourceViewController view];
    	    UIView *desView = [desViewController view];
    	    desView.transform = srcView.transform;
    	    desView.bounds = srcView.bounds;
    	    if(isLandscapeOrientation)
    	    {
    	        if(isDismiss)
    	        {
                    	            desView.center = CGPointMake(srcView.center.x, srcView.center.y  - srcView.frame.size.height);
                    	        }
            	        else
            	        {
                    	            desView.center = CGPointMake(srcView.center.x, srcView.center.y  + srcView.frame.size.height);
                    	        }
            	    }
    	    else
        	    {
            	        if(isDismiss)
                	        {
                    	            desView.center = CGPointMake(srcView.center.x - srcView.frame.size.width, srcView.center.y);
                    	        }
            	        else
                	        {
                    	            desView.center = CGPointMake(srcView.center.x + srcView.frame.size.width, srcView.center.y);
                    	        }
            	    }
    
    
    	    UIWindow *mainWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
    	    [mainWindow addSubview:desView];
    
    	    // slide newView over oldView, then remove oldView
    	    [UIView animateWithDuration:0.3
                                  animations:^{
                 	                         desView.center = CGPointMake(srcView.center.x, srcView.center.y);
                 
                 	                         if(isLandscapeOrientation)
                     	                         {
                        	                             if(isDismiss)
                                                          {
                                 	                                 srcView.center = CGPointMake(srcView.center.x, srcView.center.y + srcView.frame.size.height);
                                 	                             }
                         	                             else
                                                          {
                                 	                                 srcView.center = CGPointMake(srcView.center.x, srcView.center.y - srcView.frame.size.height);
                                 	                             }
                         	                         }
                 	                         else
                     	                         {
                                                      if(isDismiss)
                             	                             {
                                                                  srcView.center = CGPointMake(srcView.center.x + srcView.frame.size.width, srcView.center.y);
                                 	                             }
                         	                             else
                             	                             {
                                 	                                 srcView.center = CGPointMake(srcView.center.x - srcView.frame.size.width, srcView.center.y);
                                 	                             }
                         	                         }
                 	                     }
             	                     completion:^(BOOL finished){
                 	                         //[desView removeFromSuperview];
                 	                         [self.sourceViewController presentModalViewController:desViewController animated:NO];
                 	                     }];

}

@end
