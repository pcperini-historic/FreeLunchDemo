//
//  FLLoginViewController.m
//  FreeLunchDemo
//
//  Created by Patrick Perini on 1/26/14.
//  Copyright (c) 2014 FreeLunch. All rights reserved.
//

#import "FLLoginViewController.h"
#import "UIView+FLAnimations.h"

#pragma mark - Internal Constants
NSString *const FLLoginViewControllerShowMapSegueIdentifier = @"ShowMapSegue";

@implementation FLLoginViewController

#pragma mark - Accessors
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - View Lifecycle Handlers
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Responders
- (void)loginButtonWasPressed:(id)sender
{
    if (sender != [self loginButton])
        return;
    
    [[self loginButton] popOutWithCompletion: ^()
    {
        [[self loginButton] removeFromSuperview];
        [[self activityIndicatorView] startAnimating];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.66 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^()
        {
            [[self logoImageView] slideConstraint: [self logoImageViewVerticalConstraint] upOffscreenWithCompletion: ^()
            {
                [[self activityIndicatorView] popOutWithCompletion: ^()
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.50 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^()
                    {
                        [self performSegueWithIdentifier: FLLoginViewControllerShowMapSegueIdentifier sender: self];
                    });
                }];
            }];
        });
    }];
}

@end
