//
//  RZDatePickerCell.h
//  WhatFor
//
//  Created by Rusty Zarse on 9/9/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - RZDatePickerCellDelegate
@class RZDatePickerCell;

@protocol RZDatePickerCellDelegate <NSObject>


@optional
- (void)datePickerCell:(RZDatePickerCell *)iCell didEndEditingWithDate:(NSDate *)iDate;

@end

#pragma mark - RZDatePickerCell Interface

@interface RZDatePickerCell : UITableViewCell

#pragma mark - Properties
@property (nonatomic, weak) id<RZDatePickerCellDelegate> delegate;

@property (nonatomic, assign, getter = isTapGestureDismissEnabled) BOOL tapGestureDismissEnabled;

#pragma mark - Custom Setters
- (void)setDatePickerMode:(UIDatePickerMode)iMode;

@end
