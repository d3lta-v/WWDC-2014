//
//  ViewController.h
//  Pan Ziyue
//
//  Created by Pan Ziyue on 8/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *hiLabel;
@property (strong, nonatomic) IBOutlet UILabel *ziyueLabel;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *slideLabel;
- (IBAction)tapToBegin:(id)sender;

@end
