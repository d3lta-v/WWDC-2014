//
//  CompanyViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 10/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "CompanyViewController.h"
#import "REFrostedViewController.h"
#import "CommonMethods.h"

#define kAnimationTime 0.65

@interface CompanyViewController ()

@end

@implementation CompanyViewController

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
    
    // Set all alpha to zero
    _menuButton.alpha=0;
    _arrowImg.alpha=0;
    for (UILabel *label in _words) {
        label.alpha=0;
    }
    
    [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:0] delegate:self timeTaken:kAnimationTime completionBlock:^(bool finished){
        [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:1] delegate:self timeTaken:kAnimationTime completionBlock:^(bool finished){
            [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:2] delegate:self timeTaken:kAnimationTime completionBlock:^(bool finished){
                [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:3] delegate:self timeTaken:kAnimationTime completionBlock:^(bool finished){
                    [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:4] delegate:self timeTaken:kAnimationTime completionBlock:^(bool finished){
                        
                        // Roll in the animation for the screen and stuff, I will put it in a seperate method
                        [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:5] delegate:self timeTaken:kAnimationTime completion:@selector(animation5Stopped)];
                    }];
                }];
            }];
        }];
    }];
}

-(void)animation5Stopped
{
    // At this point the last line of text is rolled out
    [CommonMethods labelAnimateEaseIn:(UILabel *)_menuButton delegate:self timeTaken:kAnimationTime completion:@selector(animationButtonStopped)];
}

-(void)animationButtonStopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:6] delegate:nil timeTaken:kAnimationTime completion:nil];
    [CommonMethods labelAnimateEaseIn:(UILabel *)_arrowImg delegate:nil timeTaken:kAnimationTime completion:nil];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuPressed:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

@end
