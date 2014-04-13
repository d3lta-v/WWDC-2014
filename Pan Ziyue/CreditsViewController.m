//
//  CreditsViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 13/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "CreditsViewController.h"
#import "CommonMethods.h"
#import "REFrostedViewController/REFrostedViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface CreditsViewController ()
{
    CMMotionManager *motionManager;
    UIPushBehavior *_userDragBehavior;
}

@end

@implementation CreditsViewController

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
    
    [self startMotionUpdates];
    [self startGravity];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startGravity
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [(UILabel *)[self.words objectAtIndex:0] addGestureRecognizer:gesture];
    
    NSArray *gravityItems = [NSArray arrayWithObjects:
                             [self.words objectAtIndex:0],
                             [self.words objectAtIndex:1],
                             [self.words objectAtIndex:2],
                             [self.words objectAtIndex:3],
                             [self.words objectAtIndex:4],
                             [self.words objectAtIndex:5],
                             [self.words objectAtIndex:6],
                             [self.words objectAtIndex:7],
                             [self.words objectAtIndex:8],
                             [self.words objectAtIndex:9],
                             [self.words objectAtIndex:10],
                             nil];
    
    self.gravity = [[UIGravityBehavior alloc] initWithItems:gravityItems];
    [self.animator addBehavior:self.gravity];
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:gravityItems];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
    UIDynamicItemBehavior *elasticityBehavior = [[UIDynamicItemBehavior alloc] initWithItems:gravityItems];
    elasticityBehavior.elasticity = 0.55f;
    [self.animator addBehavior:elasticityBehavior];
}

- (void)handleGesture:(UIPanGestureRecognizer *)recognizer
{
    // If we're starting the gesture then create a drag force
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if(_userDragBehavior) {
            [_animator removeBehavior:_userDragBehavior];
        }
        _userDragBehavior = [[UIPushBehavior alloc] initWithItems:@[recognizer.view] mode:UIPushBehaviorModeContinuous];
        [_animator addBehavior:_userDragBehavior];
    }
    
    // Set the force to be proportional to distance the gesture has moved
    _userDragBehavior.pushDirection = CGVectorMake([recognizer translationInView:self.view].x / 10.f, 0);
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [_animator removeBehavior:_userDragBehavior];
        _userDragBehavior = nil;
    }
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
@end
