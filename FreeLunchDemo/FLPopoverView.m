//
//  FLPopoverView.m
//  FreeLunchDemo
//
//  Created by Patrick Perini on 1/25/14.
//  Copyright (c) 2014 FreeLunch. All rights reserved.
//

#import "FLPopoverView.h"

@implementation FLPopoverView

#pragma mark - Drawing Handlers
- (void)drawRect:(CGRect)rect
{
    CGSize arrowSize = CGSizeMake(24, 18);
    CGRect bubbleBounds = [self bounds];
    bubbleBounds.size.height -= arrowSize.height;
    
    UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithRoundedRect: bubbleBounds cornerRadius: 7];
    
    CGPoint arrowDrawPoint = CGPointMake(CGRectGetMidX(bubbleBounds), CGRectGetMaxY([self bounds]));
    [backgroundPath moveToPoint: arrowDrawPoint];
    
    arrowDrawPoint.x += arrowSize.width / 2.0;
    arrowDrawPoint.y -= arrowSize.height;
    [backgroundPath addLineToPoint: arrowDrawPoint];
    
    arrowDrawPoint.x -= arrowSize.width;
    [backgroundPath addLineToPoint: arrowDrawPoint];
    
    arrowDrawPoint.x += arrowSize.width / 2.0;
    arrowDrawPoint.y += arrowSize.height;
    [backgroundPath addLineToPoint: arrowDrawPoint];
    
    [[self tintColor] setFill];
    [backgroundPath fill];
}

@end
