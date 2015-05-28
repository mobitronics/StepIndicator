//
//  StepIndicatorView.m
//  StepIndicator
//
//  Created by Pranay on 19/05/15.
//  Copyright (c) 2015 mobitronics. All rights reserved.
//

#import "StepIndicatorView.h"

#define kIndicatorColor        [UIColor colorWithRed:(0.0f/255.0f) green:(158.0f/255.0f) blue:(152.0f/255.0f) alpha:1.0f]
#define kIndicatorFont         [UIFont fontWithName:@"Avenir-Medium" size:16.0f]

@interface StepIndicatorView () {
  int outerRadius;
  int maxIndicatorCount;
}

@end

@implementation StepIndicatorView

/**
 *  This method is used to init view with given fram and maximum indicator count
 *
 *  @param frame    view frame
 *  @param maxCount indicator count
 *
 *  @return view object
 */
- (id)initWithFrame:(CGRect)frame andIndicatorCount:(int)maxCount {
  self = [super initWithFrame:frame];
  if (self) {
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    //INITIALIZE VARIABLES
    outerRadius = 14;
    maxIndicatorCount = maxCount+1;
    
    //UPDATE INDICATOR VIEW
    [self willUpdateViewWithFilledIndicatorCount:1];
  }
  return self;
}

/**
 *  This method is used to draw the step indicator view 
 with filled and empty circle at give positions.
 *
 *  @param filledIndicatorCount integer Position
 */
- (void)willUpdateViewWithFilledIndicatorCount:(int)filledIndicatorCount {

  //TO REMOVE THE ALREADY ADDED LAYERS
  if ([self.layer sublayers]) {
    self.layer.sublayers = nil;
  }
  
  CGFloat difference = (self.frame.size.width)/maxIndicatorCount;
  
  for (int iCount=1; iCount<maxIndicatorCount; iCount++) {
    
    CGFloat yPos = CGRectGetMidY(self.frame);
    CGFloat xPos = difference*iCount;
    
    //TO DRAW THE LINE
    if (iCount != maxIndicatorCount-1) {
      [self makeLineLayer:self.layer lineFromPointA:CGPointMake(xPos+outerRadius, yPos) toPointB:CGPointMake((difference*(iCount+1))-outerRadius, yPos)];
    }
    
    //TO DRAW FILLED AND EMPTY CIRCLE
    if (iCount <= filledIndicatorCount) {
      [self drawFillCircleWithxPosition:xPos yPosition:yPos andCount:iCount];
    } else {
      [self drawEmptyCircleWithxPosition:xPos yPosition:yPos andCount:iCount];
    }
  }
}

/**
 *  This method is used to draw the empty circle with give position
 *
 *  @param xPos  x position
 *  @param yPos  y position
 *  @param count current count
 */
- (void)drawEmptyCircleWithxPosition:(CGFloat)xPos yPosition:(CGFloat)yPos andCount:(int)count {
  
  // Set up the shape of the circle
  CAShapeLayer *circle = [CAShapeLayer layer];
  // Make a circular shape
  circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*outerRadius, 2.0*outerRadius)
                                           cornerRadius:outerRadius].CGPath;
  // Center the shape in self.view
  circle.position = CGPointMake(xPos-outerRadius, yPos-outerRadius);
  
  // Configure the apperence of the circle
  circle.fillColor = [UIColor clearColor].CGColor;
  circle.strokeColor = kIndicatorColor.CGColor;
  circle.lineWidth = 1;
  circle.contentsScale = [[UIScreen mainScreen] scale];
  [self.layer addSublayer:circle];
  
  //DRAW TEXT
  int innerRadius = 10;
  CATextLayer *textLayer = [CATextLayer layer];
  textLayer.frame = CGRectMake(0, 0, 2.0*innerRadius, 2.0*innerRadius);
  textLayer.font = CFBridgingRetain(kIndicatorFont.fontName);
  textLayer.fontSize = 16;
  textLayer.foregroundColor = kIndicatorColor.CGColor;
  textLayer.backgroundColor = [UIColor clearColor].CGColor;
  textLayer.string = [NSString stringWithFormat:@"%d", count];
  textLayer.position = CGPointMake(xPos, yPos);
  textLayer.alignmentMode = kCAAlignmentCenter;
  textLayer.contentsScale = [[UIScreen mainScreen] scale];
  [self.layer addSublayer:textLayer];
}

/**
 *  This method is used to draw the line between two circles
 *
 *  @param layer  layer object
 *  @param pointA strart point
 *  @param pointB end point
 */
- (void)makeLineLayer:(CALayer *)layer lineFromPointA:(CGPoint)pointA toPointB:(CGPoint)pointB {
  
  CAShapeLayer *line = [CAShapeLayer layer];
  UIBezierPath *linePath=[UIBezierPath bezierPath];
  [linePath moveToPoint: pointA];
  [linePath addLineToPoint:pointB];
  line.path=linePath.CGPath;
  line.fillColor = nil;
  line.opacity = 1.0;
  line.strokeColor = kIndicatorColor.CGColor;
  [layer addSublayer:line];
}

/**
 *  This method is used to draw the filled circle on given postion
 *
 *  @param xPos  x position
 *  @param yPos  y position
 *  @param count current count
 */
- (void)drawFillCircleWithxPosition:(CGFloat)xPos yPosition:(CGFloat)yPos andCount:(int)count {

  // DRAW OUTER CIRCLE
  CAShapeLayer *circle = [CAShapeLayer layer];
  circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*outerRadius, 2.0*outerRadius)
                                           cornerRadius:outerRadius].CGPath;
  circle.position = CGPointMake(xPos-outerRadius, yPos-outerRadius);
  circle.fillColor = [UIColor clearColor].CGColor;
  circle.strokeColor = kIndicatorColor.CGColor;
  circle.lineWidth = 1;
  circle.contentsScale = [[UIScreen mainScreen] scale];
  [self.layer addSublayer:circle];

  // DRAW INNER CIRCLE
  int innerRadius = 10;
  CAShapeLayer *innerCircle = [CAShapeLayer layer];
  innerCircle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*innerRadius, 2.0*innerRadius)
                                           cornerRadius:innerRadius].CGPath;
  innerCircle.position = CGPointMake(xPos-innerRadius, yPos-innerRadius);
  innerCircle.fillColor = kIndicatorColor.CGColor;
  innerCircle.strokeColor = kIndicatorColor.CGColor;
  innerCircle.lineWidth = 1;
  innerCircle.contentsScale = [[UIScreen mainScreen] scale];
  [self.layer addSublayer:innerCircle];

  //DRAW TEXT
  CATextLayer *textLayer = [CATextLayer layer];
  textLayer.frame = CGRectMake(0, 0, 2.0*innerRadius, 2.0*innerRadius);
  textLayer.font = CFBridgingRetain(kIndicatorFont.fontName);
  textLayer.fontSize = 16;
  textLayer.foregroundColor = [UIColor whiteColor].CGColor;
  textLayer.backgroundColor = [UIColor clearColor].CGColor;
  textLayer.alignmentMode = kCAAlignmentCenter;
  textLayer.string = [NSString stringWithFormat:@"%d", count];
  textLayer.position = CGPointMake(xPos, yPos);
  //Need to add to remove the bluriness
  textLayer.contentsScale = [[UIScreen mainScreen] scale];
  [self.layer addSublayer:textLayer];
}

@end
