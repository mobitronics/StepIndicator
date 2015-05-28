//
//  StepIndicatorView.h
//  StepIndicator
//
//  Created by Pranay on 19/05/15.
//  Copyright (c) 2015 mobitronics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepIndicatorView : UIView

/**
 *  This method is used to init view with given fram and maximum indicator count
 *
 *  @param frame    view frame
 *  @param maxCount indicator count
 *
 *  @return view object
 */
- (id)initWithFrame:(CGRect)frame andIndicatorCount:(int)maxCount;

/**
 *  This method is used to draw the step indicator view
 with filled and empty circle at give positions.
 *
 *  @param filledIndicatorCount integer Position
 */
- (void)willUpdateViewWithFilledIndicatorCount:(int)filledIndicatorCount;

@end
