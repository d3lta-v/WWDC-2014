//
//  CommonMethods.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 10/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "CommonMethods.h"

@implementation CommonMethods

+(void)labelAnimateEaseIn:(UILabel *)label delegate:(id)delegate timeTaken:(NSTimeInterval)duration completion:(SEL)selector
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:delegate];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:duration];
    label.alpha=1;
    [UIView setAnimationDidStopSelector:selector];
    [UIView commitAnimations];
}

+(UIInterpolatingMotionEffect *)getInterpolatingMotionEffect:(NSString *)type minMaxValues:(NSInteger)minMaxValues
{
    UIInterpolatingMotionEffect *motionEffect;
    if ([type isEqualToString:@"center.y"]) {
        motionEffect=[[UIInterpolatingMotionEffect alloc] initWithKeyPath:type type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    }
    else if ([type isEqualToString:@"center.x"]) {
        motionEffect=[[UIInterpolatingMotionEffect alloc] initWithKeyPath:type type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    }
    else
        return nil; // crash and burn
    
    motionEffect.minimumRelativeValue = @((int)minMaxValues);
    motionEffect.maximumRelativeValue = @(abs((int)minMaxValues));
    
    return motionEffect;
}

@end
