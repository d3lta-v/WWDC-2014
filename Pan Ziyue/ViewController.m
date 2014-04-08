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

@synthesize ziyueLabel, hiLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    ziyueLabel.alpha=0.0f;
    hiLabel.alpha=0.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1];
    hiLabel.alpha=1;
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:1];
        ziyueLabel.alpha=1;
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
        [UIView commitAnimations];
    });
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    //[UIView beginAnimations:nil context:nil];
    
    //hiLabel.alpha=1.0f;
    
    //feed.alpha = 1.0;
    //NSString *nextFeed = [self getNextFeed]; // Need to implement getNextFeed
    //if (nextFeed)
    //{
        // Only continue if there is a next feed.
        //[feed setText:nextFeed];
        //[self performAnimation];
    //}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
