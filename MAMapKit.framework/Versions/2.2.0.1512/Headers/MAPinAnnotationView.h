//
//  MAPinAnnotationView.h
//  MAMapKit
//
//  Created by xiaoming han on 13-12-24.
//  Copyright (c) 2013年 xiaoming han. All rights reserved.
//

#import "MAAnnotationView.h"

enum {
    MAPinAnnotationColorRed = 0,
    MAPinAnnotationColorGreen,
    MAPinAnnotationColorPurple
};
typedef NSUInteger MAPinAnnotationColor;

/*!
 @brief 提供类似大头针效果的annotation view
 */
@interface MAPinAnnotationView : MAAnnotationView

/*!
 @brief 大头针的颜色，有MAPinAnnotationColorRed, MAPinAnnotationColorGreen, MAPinAnnotationColorPurple三种
 */
@property (nonatomic) MAPinAnnotationColor pinColor;

/*!
 @brief 动画效果
 */
@property (nonatomic) BOOL animatesDrop;

@end
