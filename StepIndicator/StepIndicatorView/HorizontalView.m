//
//  horizontalStepIndicatorView.m
//  StepIndicator
//
//  Created by Pranay on 20/05/15.
//  Copyright (c) 2015 mobitronics. All rights reserved.
//

#import "HorizontalView.h"

@implementation HorizontalView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[self prepareRandomColor]];
  }
  return self;
}

/**
 *  This method is used to create the random color objects
 *
 *  @return <#return value description#>
 */
- (UIColor *)prepareRandomColor {
  NSInteger aRedValue = arc4random()%255;
  NSInteger aGreenValue = arc4random()%255;
  NSInteger aBlueValue = arc4random()%255;
  
  return [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
}

@end
