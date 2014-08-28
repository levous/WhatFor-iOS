//
//  NSDateFormatter+RZSharedDateFormatters.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/27/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (RZSharedDateFormatters)
+ (NSString *)shortStringFromDate:(NSDate *)date;
@end
