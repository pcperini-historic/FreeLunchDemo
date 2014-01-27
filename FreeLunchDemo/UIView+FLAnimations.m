//
//  UIView+FLAnimations.m
//  FreeLunchDemo
//
//  Created by Patrick Perini on 1/26/14.
//  Copyright (c) 2014 FreeLunch. All rights reserved.
//

#import "UIView+FLAnimations.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (FLAnimations)

#pragma mark - Animation Setup/Teardown Handlers
- (void)setupForPopIn
{
    [self setAlpha: 0];
    
    CATransform3D transform = CATransform3DMakeScale(0, 0, 1);
    [[self layer] setTransform: transform];
}

#pragma mark - Animation Handlers
- (void)popInWithDelay:(CGFloat)delay
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^()
    {
        [UIView animateWithDuration: 0.33 animations: ^()
        {
            [self setAlpha: 1];
        
            CATransform3D transform = CATransform3DMakeScale(1.25, 1.25, 1);
            [[self layer] setTransform: transform];
        } completion: ^(BOOL finished)
        {
            [UIView animateWithDuration: 0.11 animations: ^()
            {
                CATransform3D transform = CATransform3DMakeScale(1, 1, 1);
                [[self layer] setTransform: transform];
            }];
        }];
    });
}

- (void)popOutWithCompletion:(void(^)())completion
{
    [UIView animateWithDuration: 0.11 animations: ^()
    {
        CATransform3D transform = CATransform3DMakeScale(1.25, 1.25, 1);
        [[self layer] setTransform: transform];
    } completion: ^(BOOL finished)
    {
        [UIView animateWithDuration: 0.33 animations: ^()
        {
            [self setAlpha: 0];
            
            CATransform3D transform = CATransform3DMakeScale(0, 0, 1);
            [[self layer] setTransform: transform];
        } completion: ^(BOOL finished)
        {
            if (completion)
            {
                completion();
            }
        }];
    }];
}

- (void)slideConstraint:(NSLayoutConstraint *)constraint upOffscreenWithCompletion:(void (^)())completion
{
    [constraint setConstant: -CGRectGetWidth([self bounds])];
    [UIView animateWithDuration: 0.33 animations: ^()
    {
        [self layoutIfNeeded];
    } completion: ^(BOOL finished)
    {
        if (completion)
        {
            completion();
        }
    }];
}

@end
