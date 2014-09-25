//
//  RZMilestoneCell.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZMilestoneCell.h"
#import "RZMilestoneViewModel.h"
#import "UIView+QuartzEffects.h"

@implementation RZMilestoneCell

NSString* const kStartIconImageName = @"StartIconImage";
NSString* const kCompleteIconImageName = @"CheckIconImage";


+ (NSString *)defaultReuseIdentifier{ return @"milestoneCell"; }
+ (NSString *)defaultNibName{ return @"MilestoneTableCell"; }



- (id)initWithCoder:(NSCoder *)aDecoder{
    self =  [super initWithCoder:aDecoder];
    if(self){
        [self addRoundBorder:[self completeButton]];
    }
    return self;
}

- (void)awakeFromNib{
    [self addRoundBorder:[self completeButton]];
    // transparent white to brighten content area and create interesting line for disclosure
    [[self contentView] setBackgroundColor:[UIColor colorWithHue:1.0 saturation:0.0 brightness:1.0 alpha:0.3]];
}

//NOTE: weak reference.  Used to populate other data and then discarded
- (RZMilestoneViewModel *)milestoneViewModel{
    return _milestoneViewModel;
}

- (void)setMilestoneViewModel:(RZMilestoneViewModel *)milestoneViewModel{
    _milestoneViewModel = milestoneViewModel;
    
    [[self titleLabel] setText:[milestoneViewModel title]];
    
    // evaluate milestone status
    
    [self applyStatusUIStyling];
    
    BOOL isCompleted = ( [[milestoneViewModel status] status] == RZActivityStatusComplete );
    [[self completeButton] setHidden:isCompleted];
    [[self completeIconImage] setHidden:!isCompleted];

}

- (void)applyStatusUIStyling{
    
    switch ([[[self milestoneViewModel] status] status]){
        case RZActivityStatusInProgress:
            [[self completeButton] setImage:[UIImage imageNamed:kCompleteIconImageName] forState:UIControlStateNormal];
            break;
        case RZActivityStatusBlocked:
            [[self contentView] flashElipseWithColor:[[[self milestoneViewModel] status] color]];
            // fall through to default
        default:
            [[self completeButton] setImage:[UIImage imageNamed:kStartIconImageName] forState:UIControlStateNormal];
            break;
    }
    [[self statusLabel] setText:[[[self milestoneViewModel] status] title]];
    [[self statusLabel] setTextColor:[[[self milestoneViewModel] status] color]];
    [self setBackgroundColor:[[[self milestoneViewModel] status] backgroundColor]];

}

- (void)addRoundBorder:(UIView *)view{
    view.layer.cornerRadius = 5;
    view.layer.borderWidth = 0.5;
    
    // blue view.layer.borderColor = [UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:0.5].CGColor;
    view.layer.borderColor = [UIColor colorWithRed:167.0/255.0 green:140.0/255.0 blue:98.0/255.0 alpha:0.25].CGColor;
    view.layer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if(selected && [self delegate] != nil){
        [[self delegate] didSelectMilestoneCell:self];
    }
}
- (IBAction)milestoneStatusIconButtonPressed:(id)sender {
    if([self delegate] != nil){
        [[self milestoneViewModel] promoteToNextStatus];
        [[self delegate] rzMilestoneCell:self didUpdateStatusOnMilestone:[self milestoneViewModel]];
    }
}

- (void)animateTransitionToCurrentStatus {
    UIView *buttonView = self.completeButton;
    UIView *imageView = self.completeIconImage;
    RZMilestoneViewModel *viewModel = [self milestoneViewModel];
    RZMilestoneCell *cell = self;
    
    buttonView.transform = CGAffineTransformIdentity;
    imageView.transform = CGAffineTransformIdentity;
    
    //CGRect buttonFrame = [buttonView frame];
    
    [UIView animateWithDuration:0.1 animations:^{
        // set alpha and grow a touch
        buttonView.alpha = 1.0;
        buttonView.transform = CGAffineTransformMakeScale(1.05, 1.05);
        
    } completion:^(BOOL iFinished) {
        [UIView animateWithDuration:(0.4) animations:^{
            // scale to near zero and fade out
            buttonView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            buttonView.backgroundColor = [UIColor clearColor];
            buttonView.alpha = 0.0;
            // scale the image, too (so it can be scaled back in)
            imageView.transform =  CGAffineTransformMakeScale(0.01, 0.01);
            // transition cell to new color
            cell.backgroundColor =  [[viewModel status] backgroundColor];
            // fade label out for change
            [[self statusLabel] setAlpha:0.0];
            
        } completion:^(BOOL iFinished) {
            // unless completed, the button will change icons and reappear
            UIView *viewToHide = imageView;
            UIView *viewToShow = buttonView;
            
            // if completed
            if ([[viewModel status] status] == RZActivityStatusComplete) {
                // hide the button and appear the image
                viewToHide = buttonView;
                viewToShow = imageView;
            }
            
            // hide the unused control
            [viewToHide setHidden:YES];
            // reset it's frame for later reuse
            viewToShow.transform = CGAffineTransformIdentity;
            // reset both alpha
            viewToHide.alpha = 1.0;
            viewToShow.alpha = 1.0;
            
            // unhide the desired control
            viewToShow.hidden = NO;
            
            [cell applyStatusUIStyling];
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                // animate it to the identity transform (100% scale)
                viewToShow.transform = CGAffineTransformIdentity;
                // fade label back in with change
                [[self statusLabel] setAlpha:1.0];
            } completion:^(BOOL finished){
                // ensure both controls are reset to identity transform for cell reuse
                buttonView.transform = CGAffineTransformIdentity;
                imageView.transform = CGAffineTransformIdentity;
            }];

        }];
    }];
}


@end
