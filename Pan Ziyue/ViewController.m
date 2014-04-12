//
//  ViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 8/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "ViewController.h"
#import "CommonMethods.h"

#define kAnimationTime 0.75

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Setup parallax effect
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[[CommonMethods getInterpolatingMotionEffect:@"center.x" minMaxValues:-10], [CommonMethods getInterpolatingMotionEffect:@"center.y" minMaxValues:-10]];
    
    // Add both effects to your view
    [_hiLabel addMotionEffect:group];
    [_ziyueLabel addMotionEffect:group];
    [_welcomeLabel addMotionEffect:group];
    [_slideLabel addMotionEffect:group];
    
    // Animate 'Hi'
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ziyueLabel.alpha=0.0f;
        _hiLabel.alpha=0.0f;
        _welcomeLabel.alpha=0.0f;
        _slideLabel.alpha=0.0f;
        
        // Some nested completion blocks from my CommonMethods class, replacing the previous selector based system
        [CommonMethods labelAnimateEaseIn:_hiLabel delegate:self timeTaken:1 completionBlock:^(bool finished){
            [CommonMethods labelAnimateEaseIn:_ziyueLabel delegate:self timeTaken:kAnimationTime completionBlock:^(bool finished){
                [CommonMethods labelAnimateEaseIn:_welcomeLabel delegate:self timeTaken:kAnimationTime completionBlock:^(bool finished){
                    [CommonMethods labelAnimateEaseIn:_slideLabel delegate:nil timeTaken:kAnimationTime completion:NULL];
                }];
            }];
        }];
    });
}

- (BOOL)prefersStatusBarHidden // Hide the status bar
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end