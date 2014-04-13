//
//  HexBTViewController.h
//  Pan Ziyue
//
//  Created by Pan Ziyue on 12/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface HexBTViewController : UIViewController <SKStoreProductViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *hexbtIcon;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *appstoreButton;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *words;

- (IBAction)menuPressed:(id)sender;
- (IBAction)appstoreButton:(id)sender;

@end