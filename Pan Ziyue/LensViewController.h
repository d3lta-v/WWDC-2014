//
//  LensViewController.h
//  Pan Ziyue
//
//  Created by Pan Ziyue on 12/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface LensViewController : UIViewController <SKStoreProductViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *lensIcon;
@property (weak, nonatomic) IBOutlet UIButton *appStoreButton;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *words;

- (IBAction)launchAppStore:(id)sender;
- (IBAction)menuPressed:(id)sender;

@end