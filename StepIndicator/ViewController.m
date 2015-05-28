//
//  ViewController.m
//  StepIndicator
//
//  Created by Pranay on 19/05/15.
//  Copyright (c) 2015 mobitronics. All rights reserved.
//

#import "ViewController.h"
#import "StepIndicatorView.h"
#import "HorizontalView.h"

#define kIndicatorColor        [UIColor colorWithRed:(0.0f/255.0f) green:(158.0f/255.0f) blue:(152.0f/255.0f) alpha:1.0f]
#define kStepIndicatorViewHeight    100
#define kLabelSize                  150

@interface ViewController () <UIScrollViewDelegate> {
  StepIndicatorView *stepIndicatorView;
  UIScrollView  *horizontalScrollView;
  int maxCount;
  UILabel *pageNoLabel;
}

@end

@implementation ViewController

#pragma View Lifecycle methods

- (void)viewDidLoad {
  [super viewDidLoad];
  //Set the maximun count for the step indicator
  maxCount = 5;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  [self initStepIndicatorView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/**
 *  This methos is used to create the Step Indicator View
 */
- (void)initStepIndicatorView {
  
  //Init Step Indicator View
  if (!stepIndicatorView) {
    stepIndicatorView = [[StepIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kStepIndicatorViewHeight) andIndicatorCount:maxCount];
    [self.view addSubview:stepIndicatorView];
  }
  
  //Init Horizontal scroll view to scroll witht the step indicator
  if (!horizontalScrollView) {
    horizontalScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kStepIndicatorViewHeight, self.view.frame.size.width, self.view.frame.size.height-100)];
    
    CGFloat xPos = 0;
    for (int iCount=0; iCount<maxCount; iCount++) {
      HorizontalView *horizontalView = [[HorizontalView alloc] initWithFrame:CGRectMake(xPos, 0, horizontalScrollView.frame.size.width, horizontalScrollView.frame.size.height)];
      [horizontalScrollView addSubview:horizontalView];
      xPos += horizontalScrollView.frame.size.width;
    }
    horizontalScrollView.pagingEnabled = YES;
    horizontalScrollView.delegate = self;
    horizontalScrollView.showsHorizontalScrollIndicator = NO;
    horizontalScrollView.showsVerticalScrollIndicator = NO;
    horizontalScrollView.contentSize = CGSizeMake(xPos, horizontalScrollView.frame.size.height-100);
    [self.view addSubview:horizontalScrollView];
  }
  
  //Display page number
  if (!pageNoLabel) {
    pageNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kLabelSize, kLabelSize)];
    pageNoLabel.center = self.view.center;
    [pageNoLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:30.0f]];
    [pageNoLabel setTextColor:kIndicatorColor];
    pageNoLabel.text = [NSString stringWithFormat:@"Page No: %d", 1];
    [self.view addSubview:pageNoLabel];
  }
}

#pragma mark - ScrollView delegate

/**
 *  UIScrollView Delegate called on scroll view scrolling
 *
 *  @param scrollView <#scrollView description#>
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  static NSInteger previousPage = 0;
  CGFloat pageWidth = scrollView.frame.size.width;
  float fractionalPage = scrollView.contentOffset.x / pageWidth;
  NSInteger page = lround(fractionalPage);
  if (previousPage != page) {
    int currentPage = (int)page+1;
    pageNoLabel.text = [NSString stringWithFormat:@"Page No: %d", currentPage];
    if (stepIndicatorView) {
      [stepIndicatorView willUpdateViewWithFilledIndicatorCount:currentPage];
    }
    previousPage = page;
  }
}

@end
