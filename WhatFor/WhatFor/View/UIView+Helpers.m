//
//  UIView+Helpers.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/29/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "UIView+Helpers.h"

@implementation UIView (Helpers)
- (UIView *)rzFirstSuperviewOfClassType:(Class)classType{
    UIView *tempView = self;
    while (tempView != nil) {
        if([tempView isKindOfClass:classType]){
            return tempView;
        }
        tempView = [tempView superview];
    }
    // not found
    return nil;
}
@end
