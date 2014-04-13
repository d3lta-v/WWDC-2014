//
//  LensViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 12/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "LensViewController.h"
#import "CommonMethods.h"
#import "REFrostedViewController/REFrostedViewController.h"
#import "SVProgressHUD/SVProgressHUD.h"

static const float_t kAnimationTime = 0.5;
static const float_t kShortAnimationTime = 0.4;

@interface LensViewController ()

@end

@implementation LensViewController

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
    
    // Setup parallax effect
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[[CommonMethods getInterpolatingMotionEffect:@"center.x" minMaxValues:-10], [CommonMethods getInterpolatingMotionEffect:@"center.y" minMaxValues:-10]];
    [_appStoreButton addMotionEffect:group];
    for (UILabel *label in self.words) {
        [label addMotionEffect:group];
    }
    [_menuButton addMotionEffect:group];
    [_lensIcon addMotionEffect:group];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Set all alpha to zero
        for (UILabel *label in self.words) {
            label.alpha=0;
        }
        _lensIcon.alpha=0;
        _appStoreButton.alpha=0;
        _menuButton.alpha=0;
        
        [self startAnimation];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)launchAppStore:(id)sender {
    [CommonMethods openAppStoreWithIdentifier:681870976 withDelegate:self];
}

- (IBAction)menuPressed:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

-(void)startAnimation
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:0] delegate:self timeTaken:kAnimationTime completionBlock:^(BOOL finished){
        [CommonMethods labelAnimateEaseIn:(UILabel *)_lensIcon delegate:nil timeTaken:kShortAnimationTime completion:nil];
        [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:1] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished) {
            [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:2] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished) {
                [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:3] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished){
                    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:4] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished)
                    {
                        [CommonMethods labelAnimateEaseIn:(UILabel *)_appStoreButton delegate:nil timeTaken:kShortAnimationTime completion:nil];
                        [CommonMethods labelAnimateEaseIn:(UILabel *)_menuButton delegate:nil timeTaken:kShortAnimationTime completion:nil];
                    }];
                }];
            }];
        }];
    }];
}

#pragma mark - SKStoreProductViewControllerDelegate

-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
