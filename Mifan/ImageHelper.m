//
//  ImageHelper.m
//  Mifan
//
//  Created by ryan on 14-4-11.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "ImageHelper.h"

@implementation ImageHelper

- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset
{
    return [self ellipseImage:image withInset:inset withBorderWidth:0 withBorderColor:[UIColor clearColor]];
}

- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f , image.size.height - inset * 2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    
    if (width > 0) {
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetLineCap(context,kCGLineCapButt);
        CGContextSetLineWidth(context, width);
        CGContextAddEllipseInRect(context, CGRectMake(inset + width/2, inset +  width/2, image.size.width - width- inset * 2.0f, image.size.height - width - inset * 2.0f));//在这个框中画圆
        
        CGContextStrokePath(context);
    }
    
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}



@end
