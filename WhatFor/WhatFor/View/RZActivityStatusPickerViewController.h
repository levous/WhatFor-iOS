//
//  RZActivityStatusPickerViewController.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/31/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZEnums.h"

@class RZActivityStatusPickerViewController;
@protocol RZActivityStatusPickerViewControllerDelegate <NSObject>
- (void)rzactivityStatusPickerViewController:(RZActivityStatusPickerViewController *)controller
                           didSelectStatus:(RZActivityStatus)status;
@end

@interface RZActivityStatusPickerViewController : UITableViewController{
    NSArray *statusArray;
}
@property(nonatomic) RZActivityStatus selectedStatus;
@property(nonatomic) id<RZActivityStatusPickerViewControllerDelegate> delegate;

@end
