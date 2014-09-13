//
//  RZUIStyleGuide.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZUIStyleGuide : NSObject
+ (UIColor *)fontColorForStatus:(RZActivityStatus)status;
+ (UIColor *)backgroundColorForStatus:(RZActivityStatus)status;
+ (void)addGradientBackgroundLightToView:(UIView *)view;
@end
