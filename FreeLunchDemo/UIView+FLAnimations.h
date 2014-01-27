//
//  UIView+FLAnimations.h
//  FreeLunchDemo
//
//  Created by Patrick Perini on 1/26/14.
//  Copyright (c) 2014 FreeLunch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FLAnimations)

#pragma mark - Animation Setup/Teardown Handlers
- (void)setupForPopIn;

#pragma mark - Animation Handlers
- (void)popInWithDelay:(CGFloat)delay;
- (void)popOutWithCompletion:(void(^)())completion;
- (void)slideConstraint:(NSLayoutConstraint *)constraint upOffscreenWithCompletion:(void(^)())completion;

@end
