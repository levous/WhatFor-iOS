//
//  RZNSDateFormatterTests.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/27/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDateFormatter+RZSharedDateFormatters.h"
@interface RZNSDateFormatterTests : XCTestCase

@end

@implementation RZNSDateFormatterTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testShortStringFromDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:2014];
    [dateComponents setMonth:4];
    [dateComponents setDay:27];
    
    NSDate *date = [calendar dateFromComponents:dateComponents];
    
    NSString *dateString = [NSDateFormatter shortStringFromDate:date];
    
    XCTAssertEqualObjects(dateString, @"4/27/14");
}

@end
