//
//  AboutMeViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 9/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "AboutMeViewController.h"
#import "CommonMethods.h" // Common methods header for code snippets that are used often
#import "REFrostedViewController.h"

static const float kAnimationTime = 0.5;

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
    group.motionEffects = @[[CommonMethods getInterpolatingMotionEffect:@"center.x" minMaxValues:-10], [CommonMethods getInterpolatingMotionEffect:@"center.y" minMaxValues:-10]];
    for (UILabel *label in self.words) {
        [label addMotionEffect:group];
    }
    [_iAmLabel addMotionEffect:group];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Animation for the words
        _iAmLabel.alpha=0;
        _menuButton.alpha=0;
        for (UILabel *label in self.words) {
            label.alpha=0;
        }
        [CommonMethods labelAnimateEaseIn:_iAmLabel delegate:self timeTaken:kAnimationTime completion:@selector(animationIAmStopped)];
    });
}

#pragma mark Selectors for animation completion
-(void)animationIAmStopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:0] delegate:self timeTaken:kAnimationTime completion:@selector(animation0Stopped)];
}

-(void)animation0Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:1] delegate:self timeTaken:kAnimationTime completion:@selector(animation1Stopped)];
}

-(void)animation1Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:2] delegate:self timeTaken:kAnimationTime completion:@selector(animation2Stopped)];
}

-(void)animation2Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:3] delegate:self timeTaken:kAnimationTime completion:@selector(animation3Stopped)];
}

-(void)animation3Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:4] delegate:self timeTaken:kAnimationTime completion:@selector(animation4Stopped)];
}

-(void)animation4Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:5] delegate:self timeTaken:kAnimationTime completion:@selector(animation5Stopped)];
}

-(void)animation5Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)_menuButton delegate:self timeTaken:kAnimationTime completion:nil];
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