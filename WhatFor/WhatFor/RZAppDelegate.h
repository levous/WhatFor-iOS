//
//  RZAppDelegate.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/25/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZCoreDataRepository.h"

@interface RZAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic, readonly) RZCoreDataRepository *coreDataRepository;
@end
