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
#import "Milestone+Enums.h"
#import "RZUIStyleGuide.h"


@interface RZGoalListViewModelTests : XCTestCase

@end

@implementation RZGoalListViewModelTests

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
    
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testViewModelData
{
    NSArray *colors = [NSArray arrayWithObjects:[RZUIStyleGuide fontColorForStatus:RZActivityStatusUnknown], [RZUIStyleGuide fontColorForStatus:RZActivityStatusInProgress], [RZUIStyleGuide fontColorForStatus:RZActivityStatusComplete], [RZUIStyleGuide fontColorForStatus:RZActivityStatusBlocked], nil];
    
    NSArray *goals = [repos getAllGoals];
    Goal *goal = [goals objectAtIndex:0];
    
    Milestone *milestone;
    
    // set status for validation
    milestone = [[goal goalMilestones]objectAtIndex:0];
    [milestone setStatus:RZActivityStatusComplete];
    milestone = [[goal goalMilestones]objectAtIndex:1];
    [milestone setStatus:RZActivityStatusInProgress];
    milestone = [[goal goalMilestones]objectAtIndex:2];
    [milestone setStatus:RZActivityStatusBlocked];
    milestone = [[goal goalMilestones]objectAtIndex:3];
    [milestone setStatus:RZActivityStatusUnknown];
    
    RZGoalListViewModel *listViewModel = [[RZGoalListViewModel alloc] initWithRepository:repos hideCompletedMilestones:NO];
    XCTAssertEqual((NSUInteger)2, [listViewModel goalCount]);
    XCTAssertEqual((NSUInteger)4, [listViewModel milestoneCountForGoalAtIndex:0]);
    XCTAssertEqual((NSUInteger)3, [listViewModel milestoneCountForGoalAtIndex:1]);
    
    NSIndexPath *indexPath;
    RZMilestoneViewModel *viewModel;
    
    indexPath  = [NSIndexPath indexPathForRow:0 inSection:0];
    viewModel = [listViewModel milestoneViewModelAtIndexPath:indexPath];
    XCTAssertNotNil([viewModel title]);
    XCTAssertNotNil([viewModel summary]);
    XCTAssertNotNil([viewModel dateDue]);
    XCTAssertNotNil([viewModel timeRemaining]);
    XCTAssertEqualObjects([[viewModel status] title], @"Completed");
    XCTAssertEqualObjects([[viewModel status] color], [colors objectAtIndex:RZActivityStatusComplete]);
    
    indexPath  = [NSIndexPath indexPathForRow:1 inSection:0];
    viewModel = [listViewModel milestoneViewModelAtIndexPath:indexPath];
    XCTAssertNotNil([viewModel title]);
    XCTAssertNotNil([viewModel summary]);
    XCTAssertNotNil([viewModel dateDue]);
    XCTAssertNotNil([viewModel timeRemaining]);
    XCTAssertEqualObjects([[viewModel status] title], @"In Progress");
    XCTAssertEqualObjects([[viewModel status] color], [colors objectAtIndex:RZActivityStatusInProgress]);
    
    indexPath  = [NSIndexPath indexPathForRow:2 inSection:0];
    viewModel = [listViewModel milestoneViewModelAtIndexPath:indexPath];
    XCTAssertNotNil([viewModel title]);
    XCTAssertNotNil([viewModel summary]);
    XCTAssertNotNil([viewModel dateDue]);
    XCTAssertNotNil([viewModel timeRemaining]);
    XCTAssertEqualObjects([[viewModel status] title], @"Blocked");
    XCTAssertEqualObjects([[viewModel status] color], [colors objectAtIndex:RZActivityStatusBlocked]);
    
    indexPath  = [NSIndexPath indexPathForRow:3 inSection:0];
    viewModel = [listViewModel milestoneViewModelAtIndexPath:indexPath];
    XCTAssertNotNil([viewModel title]);
    XCTAssertNotNil([viewModel summary]);
    XCTAssertNotNil([viewModel dateDue]);
    XCTAssertNotNil([viewModel timeRemaining]);
    XCTAssertEqualObjects([[viewModel status] title], @"Unknown");
    XCTAssertEqualObjects([[viewModel status] color], [colors objectAtIndex:RZActivityStatusUnknown]);
                                                
    
    
                   
}

- (void)testHideCompleted
{
    NSArray *goals = [repos getAllGoals];
    
    Goal *goal = [goals objectAtIndex:0];
    Milestone *milestone;
    
    // set status for validation
    milestone = [[goal goalMilestones]objectAtIndex:0];
    [milestone setStatus:RZActivityStatusComplete];
    milestone = [[goal goalMilestones]objectAtIndex:1];
    [milestone setStatus:RZActivityStatusComplete];
    milestone = [[goal goalMilestones]objectAtIndex:2];
    [milestone setStatus:RZActivityStatusBlocked];
    milestone = [[goal goalMilestones]objectAtIndex:3];
    [milestone setStatus:RZActivityStatusUnknown];
    
    RZGoalListViewModel *listViewModel = [[RZGoalListViewModel alloc] initWithRepository:repos hideCompletedMilestones:YES];

    XCTAssertEqual((NSUInteger)2, [listViewModel milestoneCountForGoalAtIndex:0]);

}

@end
