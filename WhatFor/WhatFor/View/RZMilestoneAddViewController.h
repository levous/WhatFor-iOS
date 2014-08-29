//
//  RZMilestoneAddViewController.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/29/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RZMilestoneAddViewController;
@protocol RZMilestoneAddViewControllerDelegate
- (void)milestoneAddViewControllerDidCancel:(RZMilestoneAddViewController *)controller;
- (void)milestoneAddViewControllerDidSave:(RZMilestoneAddViewController *)controller;
@end

@interface RZMilestoneAddViewController : UITableViewController
@property (nonatomic, weak) id<RZMilestoneAddViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@end
