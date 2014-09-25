//
//  RZMilestoneViewModelTests.m
//  WhatFor
//
//  Created by Rusty Zarse on 9/24/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RZMilestoneViewModel.h"
#import "RZTestingRepository.h"
#import "RZSeedDataInserter.h"
#import "Milestone+Enums.h"

@interface RZMilestoneViewModelTests : XCTestCase

@end

@implementation RZMilestoneViewModelTests

RZTestingRepository *repos;
RZSeedDataInserter *seedInserter;

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    //repos = [[RZTestingRepository alloc] init];
    // insert 2 goals with 4 and 3 milestones, respectively
    //seedInserter = [[RZSeedDataInserter alloc] initWithRepository:repos];
    //[seedInserter insert2GoalsWith4and3Milestones];

}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testDefaultValues
{
    RZMilestoneViewModel *mvm = [[RZMilestoneViewModel alloc] init];
    XCTAssertEqual([[mvm status] status], RZActivityStatusNotStarted);
}

- (void)testPromoteToNextStatus
{
    RZMilestoneViewModel *mvm = [[RZMilestoneViewModel alloc] init];
    
    [[mvm status] setStatus:RZActivityStatusBlocked];
    
    XCTAssertEqual([[mvm status] status], RZActivityStatusBlocked);
    
    [mvm promoteToNextStatus];
    XCTAssertEqual([[mvm status] status], RZActivityStatusNotStarted);
    
    [mvm promoteToNextStatus];
    XCTAssertEqual([[mvm status] status], RZActivityStatusInProgress);
    
    [mvm promoteToNextStatus];
    XCTAssertEqual([[mvm status] status], RZActivityStatusComplete);
    
}

@end
