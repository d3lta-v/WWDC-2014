//
//  SkillsViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 9/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "SkillsViewController.h"
#import "REFrostedViewController.h"
#import "CommonMethods.h"
#import "TLAlertView.h"
#import <CoreMotion/CoreMotion.h>

#define kAnimationTime 0.65

@interface SkillsViewController ()
{
    CMMotionManager *motionManager;
}

@end

@implementation SkillsViewController

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
        self.menuButton.alpha=0;
        self.iAmLabel.alpha=0;
        for (UILabel *label in self.words) {
            label.alpha=0;
        }
        [CommonMethods labelAnimateEaseIn:self.iAmLabel delegate:self timeTaken:kAnimationTime completion:@selector(animationIAmStopped)];
    });
}

#pragma mark Animation end
-(void)animationIAmStopped
{
    [CommonMethods labelAnimateEaseIn:self.iAmLabel delegate:self timeTaken:kAnimationTime completion:@selector(animation0Stopped)];
}

-(void)animation0Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:0] delegate:self timeTaken:kAnimationTime completion:@selector(animation1Stopped)];
}

-(void)animation1Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:1] delegate:self timeTaken:kAnimationTime completion:@selector(animation2Stopped)];
}

-(void)animation2Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:2] delegate:self timeTaken:kAnimationTime completion:@selector(animation3Stopped)];
}

-(void)animation3Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:3] delegate:self timeTaken:kAnimationTime completion:@selector(animation4Stopped)];
}

-(void)animation4Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:4] delegate:self timeTaken:kAnimationTime completion:@selector(animation5Stopped)];
}

-(void)animation5Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)[self.words objectAtIndex:5] delegate:self timeTaken:kAnimationTime completion:@selector(animation6Stopped)];
}

-(void)animation6Stopped
{
    [CommonMethods labelAnimateEaseIn:(UILabel *)self.menuButton delegate:nil timeTaken:kAnimationTime completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startMotionUpdates];
        [self dropTheBass];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            TLAlertView *alert = [[TLAlertView alloc] initWithTitle:@"Tip:" message:@"Try rotating your device now!" buttonTitle:@"Got it!"];
            [alert show];
        });
    });
}

#pragma mark Start motion updates
-(void)startMotionUpdates
{
    motionManager = [[CMMotionManager alloc] init];
    motionManager.deviceMotionUpdateInterval = 0.01;
    [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        CMAcceleration gravity = motion.gravity;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.gravity.gravityDirection = CGVectorMake(gravity.x, -gravity.y);
        });
    }];
}

-(void)dropTheBass
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //NSMutableArray *gravityItems;
    /*for (UILabel *label in self.words) {
        [gravityItems addObject:label];
    }*/
    //[gravityItems addObject:[self.words objectAtIndex:0]];
    //[gravityItems addObject:self.iAmLabel];
    
    NSArray *gravityItems = [NSArray arrayWithObjects:self.iAmLabel,
                             [self.words objectAtIndex:0],
                             [self.words objectAtIndex:1],
                             [self.words objectAtIndex:2],
                             [self.words objectAtIndex:3],
                             [self.words objectAtIndex:4],
                             [self.words objectAtIndex:5],
                             nil];
    
    self.gravity = [[UIGravityBehavior alloc] initWithItems:gravityItems];
    [self.animator addBehavior:self.gravity];
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:gravityItems];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
    UIDynamicItemBehavior *elasticityBehavior = [[UIDynamicItemBehavior alloc] initWithItems:gravityItems];
    elasticityBehavior.elasticity = 0.5f;
    [self.animator addBehavior:elasticityBehavior];
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
