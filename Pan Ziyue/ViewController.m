//
//  ViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 8/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize ziyueLabel, hiLabel, welcomeLabel, slideLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    ziyueLabel.alpha=0.0f;
    hiLabel.alpha=0.0f;
    welcomeLabel.alpha=0.0f;
    slideLabel.alpha=0.0f;
    
    // Setup parallax effect
    UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-10);
    verticalMotionEffect.maximumRelativeValue = @(-10);
    UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-10);
    horizontalMotionEffect.maximumRelativeValue = @(10);
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [hiLabel addMotionEffect:group];
    [ziyueLabel addMotionEffect:group];
    [welcomeLabel addMotionEffect:group];
    [slideLabel addMotionEffect:group];
    
    // Animate 'Hi'
    [self labelAnimateEaseIn:hiLabel delegate:self timeTaken:1 completion:@selector(animationDidStop:finished:)];
}

#pragma mark Animation didStop handlers

// Custom method for all the animations
-(void)labelAnimateEaseIn:(UILabel *)label delegate:(id)delegate timeTaken:(NSTimeInterval)duration completion:(SEL)selector
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:delegate];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:duration];
    label.alpha=1;
    [UIView setAnimationDidStopSelector:selector];
    [UIView commitAnimations];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag // Animate my name
{
    [self labelAnimateEaseIn:ziyueLabel delegate:self timeTaken:1 completion:@selector(animation2DidStop:finished:)];
}

-(void)animation2DidStop:(CAAnimation *)anim finished:(BOOL)flag // Animate the 'welcome' text
{
    [self labelAnimateEaseIn:welcomeLabel delegate:self timeTaken:1 completion:@selector(animation3DidStop:finished:)];
}

-(void)animation3DidStop:(CAAnimation *)anim finished:(BOOL)flag // animate the 'slide' text
{
    [self labelAnimateEaseIn:slideLabel delegate:nil timeTaken:0.5 completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapToBegin:(id)sender {
    
}

@end
