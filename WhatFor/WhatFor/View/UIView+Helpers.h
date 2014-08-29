//
//  UIView+Helpers.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/29/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helpers)
- (UIView *)rzFirstSuperviewOfClassType:(Class)classType;
@end
