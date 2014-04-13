//
//  AnnouncerViewController.h
//  Pan Ziyue
//
//  Created by Pan Ziyue on 12/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface AnnouncerViewController : UIViewController <SKStoreProductViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *announcerImg;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *words;
@property (weak, nonatomic) IBOutlet UIButton *appstoreButton;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

- (IBAction)appstoreTapped:(id)sender;
- (IBAction)menuPressed:(id)sender;

@end
