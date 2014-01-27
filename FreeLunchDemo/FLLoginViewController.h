//
//  FLLoginViewController.h
//  FreeLunchDemo
//
//  Created by Patrick Perini on 1/26/14.
//  Copyright (c) 2014 FreeLunch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLLoginViewController : UIViewController

#pragma mark - Properties
@property IBOutlet UIImageView *logoImageView;
@property IBOutlet UIImageView *nameImageView;
@property IBOutlet UIButton *loginButton;
@property IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property IBOutlet NSLayoutConstraint *logoImageViewVerticalConstraint;

#pragma mark - Responders
- (IBAction)loginButtonWasPressed:(id)sender;

@end
