//
//  RZStatusViewModel.h
//  WhatFor
//
//  Created by Rusty Zarse on 9/4/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZStatusViewModel : NSObject{
    RZActivityStatus _status;
}
@property (nonatomic) RZActivityStatus status;
@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) UIColor *color;

@end
