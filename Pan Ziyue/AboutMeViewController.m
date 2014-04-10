//
//  AboutMeViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 9/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "AboutMeViewController.h"
#import "REFrostedViewController/REFrostedViewController.h"

@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[[self getInterpolatingMotionEffect:@"center.x" minMaxValues:-10], [self getInterpolatingMotionEffect:@"center.y" minMaxValues:-10]];
    for (UILabel *label in self.words) {
        [label addMotionEffect:group];
    }
    [self.iAmLabel addMotionEffect:group];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Animation for the words
        self.iAmLabel.alpha=0;
        for (UILabel *label in self.words) {
            label.alpha=0;
        }
        [self labelAnimateEaseIn:self.iAmLabel delegate:self timeTaken:0.75 completion:@selector(animationIAmStopped)];
    });
}

#pragma mark Selectors for animation completion
-(void)animationIAmStopped
{
    [self labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:0] delegate:self timeTaken:0.85 completion:@selector(animation0Stopped)];
}

-(void)animation0Stopped
{
    [self labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:1] delegate:self timeTaken:0.85 completion:@selector(animation1Stopped)];
}

-(void)animation1Stopped
{
    [self labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:2] delegate:self timeTaken:0.85 completion:@selector(animation2Stopped)];
}

-(void)animation2Stopped
{
    [self labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:3] delegate:self timeTaken:0.85 completion:@selector(animation3Stopped)];
}

-(void)animation3Stopped
{
    [self labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:4] delegate:self timeTaken:0.85 completion:nil];
}

#pragma mark Animation method
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

#pragma mark Interpolating Motion Effect method
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

// Hide status bar
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openMenu:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

@end