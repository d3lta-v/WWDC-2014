//
//  CreditsViewController.h
//  Pan Ziyue
//
//  Created by Pan Ziyue on 13/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditsViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *words;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravity;
- (IBAction)menuPressed:(id)sender;

@end
