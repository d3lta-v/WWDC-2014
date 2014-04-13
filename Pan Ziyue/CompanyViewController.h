//
//  CompanyViewController.h
//  Pan Ziyue
//
//  Created by Pan Ziyue on 10/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *words;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *statixLogo;

- (IBAction)menuPressed:(id)sender;
- (IBAction)companyToWeb:(id)sender;

@end
