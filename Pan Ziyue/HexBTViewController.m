//
//  HexBTViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 12/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "HexBTViewController.h"
#import "REFrostedViewController/REFrostedViewController.h"
#import "CommonMethods.h"

static const float kAnimationTime = 0.5;
static const float kShortAnimationTime = 0.4;

@interface HexBTViewController ()

@end

@implementation HexBTViewController

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
    [_appstoreButton addMotionEffect:group];
    for (UILabel *label in self.words) {
        [label addMotionEffect:group];
    }
    [_hexbtIcon addMotionEffect:group];
    [_menuButton addMotionEffect:group];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Set all alpha to zero
        for (UILabel *label in self.words) {
            label.alpha=0;
        }
        _menuButton.alpha=0;
        _appstoreButton.alpha=0;
        _hexbtIcon.alpha=0;
        
        [self startAnimations];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startAnimations
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:0] delegate:self timeTaken:kAnimationTime completionBlock:^(BOOL finished){
        [CommonMethods labelAnimateEaseIn:(UILabel *)_hexbtIcon delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished){
            [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:1] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished){
                [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:2] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished){
                    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:3] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished){
                        [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:4] delegate:self timeTaken:kShortAnimationTime completionBlock:^(BOOL finished){
                            [CommonMethods labelAnimateEaseIn:(UILabel *)_appstoreButton delegate:nil timeTaken:kShortAnimationTime completionBlock:nil];
                            [CommonMethods labelAnimateEaseIn:(UILabel *)_menuButton delegate:nil timeTaken:kShortAnimationTime completionBlock:nil];
                        }];
                    }];
                }];
            }];
        }];
    }];
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

- (IBAction)menuPressed:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)appstoreButton:(id)sender {
    [CommonMethods openAppStoreWithIdentifier:698049514 withDelegate:self];
}

#pragma mark - SKStoreProductViewControllerDelegate
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
