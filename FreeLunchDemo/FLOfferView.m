//
//  FLOfferView.m
//  FreeLunchDemo
//
//  Created by Patrick Perini on 1/25/14.
//  Copyright (c) 2014 FreeLunch. All rights reserved.
//

#import "FLOfferView.h"
#import "FLOffer.h"

@implementation FLOfferView

#pragma mark - Initializers
- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation: annotation reuseIdentifier: reuseIdentifier];
    if (!self)
        return nil;
    
    CGRect bounds = [self bounds];
    bounds.size = [UIImage imageNamed: @"Free"].size;
    [self setBounds: bounds];
    
    [self setBackgroundColor: [UIColor clearColor]];
    
    return self;
}

#pragma mark - Drawing Handlers
- (void)drawRect:(CGRect)rect
{
    FLOffer *offer = (FLOffer *)[self annotation];
    
    NSString *backgroundImageName = [offer isFree]? @"Free" : @"Paid";
    UIImage *backgroundImage = [UIImage imageNamed: backgroundImageName];
    
    [backgroundImage drawInRect: [self bounds]];
    
    UIImage *iconImage = [UIImage imageNamed: [offer foodType]];
    
    CGRect iconImageFrame = CGRectZero;
    iconImageFrame.size = iconImage.size;
    [iconImage drawInRect: iconImageFrame];
}

@end
