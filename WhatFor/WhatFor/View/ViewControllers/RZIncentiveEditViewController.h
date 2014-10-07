//
//  RZMilestoneAddViewController.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/29/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZIncentiveViewModel.h"
@class RZIncentiveEditViewController;

@protocol RZIncentiveEditViewControllerDelegate
- (void)incentiveEditViewControllerDidCancel:(RZIncentiveEditViewController *)controller;
- (void)incentiveEditViewController:(RZIncentiveEditViewController *)controller didUpdateIncentive:(RZIncentiveViewModel *)incentive;
@end

@interface RZIncentiveEditViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@property (nonatomic, strong) RZIncentiveViewModel *incentiveViewModel;
@property (nonatomic, weak) id<RZIncentiveEditViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@end
