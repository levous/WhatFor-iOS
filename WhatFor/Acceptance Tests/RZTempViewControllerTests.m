//
//  RZTempViewControllerTests.m
//  WhatFor
//
//  Created by Rusty Zarse on 9/10/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZTempViewControllerTests.h"
#import "KIFUITestActor.h"

@implementation RZTempViewControllerTests

- (void)testSuccessfulLogin
{
    [tester tapViewWithAccessibilityLabel:@"All Milestones"];
    
    // Verify that the login succeeded
    [tester waitForAbsenceOfViewWithAccessibilityLabel:@"All Milestones"];
}

@end
