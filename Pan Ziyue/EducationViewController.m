//
//  EducationViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 11/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "EducationViewController.h"
#import "CommonMethods.h"
#import "REFrostedViewController/REFrostedViewController.h"
#import "WebViewController.h"

static const float_t kAnimationTime = 0.5;
static const float_t kShortAnimationTime = 0.35;

@interface EducationViewController ()

@end

@implementation EducationViewController

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
    
    // Add parallax effects
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[[CommonMethods getInterpolatingMotionEffect:@"center.x" minMaxValues:-10], [CommonMethods getInterpolatingMotionEffect:@"center.y" minMaxValues:-10]];
    
    [_menuButton addMotionEffect:group];
    [_SSTlogo addMotionEffect:group];
    [_arrowImg addMotionEffect:group];
    for (UILabel *label in self.words) {
        [label addMotionEffect:group];
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Set all alpha to 0
        for (UILabel *label in self.words) {
            label.alpha=0;
        }
        _arrowImg.alpha=0;
        _SSTlogo.alpha=0;
        _menuButton.alpha=0;
        
        [self startAnimation];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuPressed:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)logoTapped:(id)sender {
    [self performSegueWithIdentifier:@"educationToWeb" sender:self];
}

-(void)startAnimation
{
    // Start build in animations
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:0] delegate:self timeTaken:kAnimationTime completionBlock:^(BOOL finished){
        [CommonMethods labelAnimateEaseIn:(UILabel *)_SSTlogo delegate:self timeTaken:kAnimationTime completionBlock:^(BOOL finished){
            [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:1] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished){
                [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:2] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished){
                    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:3] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished){
                        [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:4] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished){
                            [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:5] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished){
                                [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:6] delegate:self timeTaken:kShortAnimationTime completion:@selector(startArrowAndLabelAnimation)];
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }];
}

-(void)startArrowAndLabelAnimation
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)_arrowImg delegate:nil timeTaken:kShortAnimationTime completion:nil];
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:7] delegate:nil timeTaken:kShortAnimationTime completion:nil];
    [CommonMethods labelAnimateEaseIn:(UILabel *)_menuButton delegate:nil timeTaken:kShortAnimationTime completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"educationToWeb"]) {
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        WebViewController *newVC = (WebViewController *)navController.topViewController;
        newVC.urlString = @"http://www.sst.edu.sg";
    }
}

@end
