//
//  ViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 8/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "ViewController.h"
#import "CommonMethods.h"

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
    group.motionEffects = @[[CommonMethods getInterpolatingMotionEffect:@"center.x" minMaxValues:-10], [CommonMethods getInterpolatingMotionEffect:@"center.y" minMaxValues:-10]];
    
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
        [CommonMethods labelAnimateEaseIn:hiLabel delegate:self timeTaken:1 completion:@selector(animationDidStop:finished:)];
    });
}

- (BOOL)prefersStatusBarHidden // Hide the status bar
{
    return YES;
}

#pragma mark Animation didStop handlers

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag // Animate my name
{
    [CommonMethods labelAnimateEaseIn:ziyueLabel delegate:self timeTaken:1 completion:@selector(animation2DidStop:finished:)];
}

-(void)animation2DidStop:(CAAnimation *)anim finished:(BOOL)flag // Animate the 'welcome' text
{
    [CommonMethods labelAnimateEaseIn:welcomeLabel delegate:self timeTaken:1 completion:@selector(animation3DidStop:finished:)];
}

-(void)animation3DidStop:(CAAnimation *)anim finished:(BOOL)flag // animate the 'slide' text
{
    [CommonMethods labelAnimateEaseIn:slideLabel delegate:nil timeTaken:0.75 completion:NULL];
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