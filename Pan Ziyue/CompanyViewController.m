//
//  CompanyViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 10/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "CompanyViewController.h"
#import "REFrostedViewController/REFrostedViewController.h"
#import "CommonMethods.h"
#import "WebViewController.h"

static const float_t kAnimationTime = 0.5;
static const float_t kShorterAnimationTime = 0.35;

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
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Set all alpha to zero
        _menuButton.alpha=0;
        _arrowImg.alpha=0;
        for (UILabel *label in _words) {
            label.alpha=0;
        }
        
        [self startAnimation];
    });
    
    // Add parallax effects
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[[CommonMethods getInterpolatingMotionEffect:@"center.x" minMaxValues:-10], [CommonMethods getInterpolatingMotionEffect:@"center.y" minMaxValues:-10]];
    
    [_menuButton addMotionEffect:group];
    [_statixLogo addMotionEffect:group];
    [_arrowImg addMotionEffect:group];
    for (UILabel *label in self.words) {
        [label addMotionEffect:group];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuPressed:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)companyToWeb:(id)sender {
    [self performSegueWithIdentifier:@"companyToWeb" sender:self];
}

#pragma mark Animation methods
-(void)startAnimation
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:0] delegate:self timeTaken:kAnimationTime completionBlock:^(BOOL finished){
        [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:1] delegate:self timeTaken:kAnimationTime completionBlock:^(BOOL finished){
            [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:2] delegate:self timeTaken:kShorterAnimationTime completionBlock:^(BOOL finished){
                [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:3] delegate:self timeTaken:kShorterAnimationTime completionBlock:^(BOOL finished){
                    [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:4] delegate:self timeTaken:kShorterAnimationTime completionBlock:^(BOOL finished){
                        
                        // Roll in the animation for the screen and stuff, I will put it in a seperate method
                        [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:5] delegate:self timeTaken:kShorterAnimationTime completion:@selector(animation5Stopped)];
                    }];
                }];
            }];
        }];
    }];
}

-(void)animation5Stopped
{
    // At this point the last line of text is rolled out
    [CommonMethods labelAnimateEaseIn:(UILabel *)_menuButton delegate:nil timeTaken:kShorterAnimationTime completion:nil];
    [CommonMethods labelAnimateEaseIn:(UILabel *)[_words objectAtIndex:6] delegate:nil timeTaken:0.3 completion:nil];
    [CommonMethods labelAnimateEaseIn:(UILabel *)_arrowImg delegate:nil timeTaken:0.3 completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"companyToWeb"]) {
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        WebViewController *newVC = (WebViewController *)navController.topViewController;
        newVC.urlString = @"https://statixind.net/about.html";
    }
}

@end
