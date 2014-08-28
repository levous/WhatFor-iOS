//
//  NSDateFormatter+RZSharedDateFormatters.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/27/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "NSDateFormatter+RZSharedDateFormatters.h"

@implementation NSDateFormatter (RZSharedDateFormatters)


static NSDateFormatter * shortDateFormatter = nil;

+ (NSDateFormatter *) RZSharedShortDateFormatter {
    
    @synchronized([NSDateFormatter class]){
        
        if( shortDateFormatter == nil){
            
            // Create new formatter for SHORT dates (e.g. 12/24/14)
            
            shortDateFormatter = [[NSDateFormatter alloc] init];
            [shortDateFormatter setDateStyle: NSDateFormatterShortStyle];
            [shortDateFormatter setTimeStyle:NSDateFormatterNoStyle];
        }
        
        return shortDateFormatter;
        
    }
    
    return nil;
}

+ (NSString *)shortStringFromDate:(NSDate *)date{
    NSDateFormatter *formatter = [NSDateFormatter RZSharedShortDateFormatter];
    return [formatter stringFromDate:date];
}


@end
