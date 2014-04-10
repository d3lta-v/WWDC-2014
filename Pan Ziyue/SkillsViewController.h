//
//  SkillsViewController.h
//  Pan Ziyue
//
//  Created by Pan Ziyue on 9/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillsViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *words;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
- (IBAction)menuPressed:(id)sender;

@end
