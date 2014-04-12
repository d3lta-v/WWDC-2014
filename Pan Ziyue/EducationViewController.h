//
//  EducationViewController.h
//  Pan Ziyue
//
//  Created by Pan Ziyue on 11/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EducationViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *words;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@property (weak, nonatomic) IBOutlet UIButton *SSTlogo;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

- (IBAction)menuPressed:(id)sender;
- (IBAction)logoTapped:(id)sender;

@end
