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
    
    // Setup parallax effect
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[[self getInterpolatingMotionEffect:@"center.x" minMaxValues:-10], [self getInterpolatingMotionEffect:@"center.y" minMaxValues:-10]];
    
    // Add both effects to your view
    [hiLabel addMotionEffect:group];
    [ziyueLabel addMotionEffect:group];
    [welcomeLabel addMotionEffect:group];
    [slideLabel addMotionEffect:group];
    
    // Animate 'Hi'
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ziyueLabel.alpha=0.0f;
        hiLabel.alpha=0.0f;
        welcomeLabel.alpha=0.0f;
        slideLabel.alpha=0.0f;
        [self labelAnimateEaseIn:hiLabel delegate:self timeTaken:1 completion:@selector(animationDidStop:finished:)];
    });
}

- (BOOL)prefersStatusBarHidden // Hide the status bar
{
    return YES;
}

// Custom method for parallax effect UIInterpolatingMotionEffect
-(UIInterpolatingMotionEffect *)getInterpolatingMotionEffect:(NSString *)type minMaxValues:(NSInteger)minMaxValues
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
    [self labelAnimateEaseIn:slideLabel delegate:nil timeTaken:0.75 completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapToBegin:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

@end