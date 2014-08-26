//
//  RZGoalListViewModelTests.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RZGoalListViewModel.h"
#import "RZTestingRepository.h"
#import "RZSeedDataInserter.h"

@interface RZGoalListViewModelTests : XCTestCase

@end

@implementation RZGoalListViewModelTests
RZGoalListViewModel *listViewModel;
RZTestingRepository *repos;
RZSeedDataInserter *seedInserter;

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    repos = [[RZTestingRepository alloc] init];
    // insert 2 goals with 4 and 3 milestones, respectively
    seedInserter = [[RZSeedDataInserter alloc] initWithRepository:repos];
    [seedInserter insert2GoalsWith4and3Milestones];
    listViewModel = [[RZGoalListViewModel alloc] initWithRepository:repos];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testViewModelData
{
    XCTAssertEqual((NSUInteger)2, [listViewModel goalCount]);
    XCTAssertEqual((NSUInteger)4, [listViewModel milestoneCountForGoalAtIndex:0]);
    XCTAssertEqual((NSUInteger)3, [listViewModel milestoneCountForGoalAtIndex:1]);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    MilestoneViewModel *viewModel = [listViewModel milestoneViewModelAtIndexPath:indexPath];
    
    // for now just checking value but should expland this to verify sh!^ as sh!^ gets implemented
    
    XCTAssertNotNil([viewModel title]);
    XCTAssertNotNil([viewModel summary]);
    XCTAssertEqualObjects([[viewModel status] title], @"Completed");
    XCTAssertNotNil([[viewModel status] color]);
    
                   
}

@end
