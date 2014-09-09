//
//  RZMilestoneAddViewController.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/29/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZMilestoneAddViewController.h"
#import "RZStringsHelper.h"
#import "RZActivityStatusPickerViewController.h"
#import "RZDatePickerCell.h"
@interface RZMilestoneAddViewController ()

@end

@implementation RZMilestoneAddViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setStatusViewModel:[[RZStatusViewModel alloc] init]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Add Milestone"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[self goalTitleLabel] setText:[[self milestoneViewModel] goalTitle]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(localeChanged:)
                                                 name:NSCurrentLocaleDidChangeNotification
                                               object:nil];
    
    [(RZDatePickerCell *)[self dueDateCell] setDelegate:self];
    
    [self populateFromViewModel];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSCurrentLocaleDidChangeNotification
                                                  object:nil];
}

#pragma mark - Locale

/*! Responds to region format or locale changes.
 */
- (void)localeChanged:(NSNotification *)notif
{
    // the user changed the locale (region format) in Settings, so we are notified here to
    // update the date format in the table view cells
    //
    [self.tableView reloadData];
}


#pragma mark - Populate data

- (void)populateFromViewModel{
    [[self titleTextField] setText:[[self milestoneViewModel] title]];
    [[self summaryTextView] setText:[[self milestoneViewModel] summary]];
    [self setDateDue:[[self milestoneViewModel] dateDue]];
    [[[self dueDateCell] textLabel] setText:[[self milestoneViewModel] dateDueText]];
    //[[self pointValueTextField] setText:[[self milestoneViewModel] ???]];
    [[[self statusTableCell] textLabel] setText:[[[self milestoneViewModel] status] title]];
    [[[self statusTableCell] textLabel] setTextColor:[[[self milestoneViewModel] status] color]];
    // copy status value to local status view model for temp storage
    [[self statusViewModel] setStatus:[[[self milestoneViewModel] status] status]];
}


#pragma mark - RZDatePickerCell Delegate
- (void)datePickerCell:(RZDatePickerCell *)iCell didEndEditingWithDate:(NSDate *)iDate{
    [self setDateDue:iDate];
    
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"pickStatusSegue"]){
        RZActivityStatusPickerViewController *destinationVC = (RZActivityStatusPickerViewController *)[segue destinationViewController];
        [destinationVC setDelegate:self];
        [destinationVC setSelectedStatus:[[[self milestoneViewModel] status] status]];
    }
}


- (void)rzactivityStatusPickerViewController:(RZActivityStatusPickerViewController *)controller
                           didSelectStatus:(RZActivityStatus)status{
    [[self statusViewModel] setStatus:status];
    [[[self statusTableCell] textLabel] setText:[[self statusViewModel] title]];
    [[[self statusTableCell] textLabel] setTextColor:[[self statusViewModel] color]];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Bar Button Handlers

- (IBAction)cancel:(id)sender
{
	[self.delegate milestoneAddViewControllerDidCancel:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)done:(id)sender
{
    RZMilestoneViewModel *mvm = [self milestoneViewModel];
    
    [mvm setTitle:[[self titleTextField] text]];
    [mvm setSummary:[[self summaryTextView] text]];
    [[mvm status] setStatus:[[self statusViewModel] status]];
    //[mvm setDateDue:[self dateDue]];
    [mvm setTitle:[[self titleTextField] text]];
    [mvm setDateDue:[self dateDue]];
	[self.delegate milestoneAddViewController:self didUpdateMilestone:[self milestoneViewModel]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
