//
//  RZSeedDataInserterTests.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RZTestingRepository.h"
#import "ModelHeader.h"
#import "RZSeedDataInserter.h"

@interface RZSeedDataInserterTests : XCTestCase

@end

@implementation RZSeedDataInserterTests


RZTestingRepository *repos;

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    repos = [[RZTestingRepository alloc] init];
    
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    RZSeedDataInserter *inserter = [[RZSeedDataInserter alloc] initWithRepository:repos];
    [inserter insert2Goals];
    
    NSArray *goals = [repos getAllGoals];
    XCTAssertEqual([goals count], (NSUInteger)2);
}

@end
