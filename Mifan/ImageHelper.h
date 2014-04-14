//
//  ImageHelper.h
//  Mifan
//
//  Created by ryan on 14-4-11.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageHelper : NSObject

- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset;

- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color;

@end
