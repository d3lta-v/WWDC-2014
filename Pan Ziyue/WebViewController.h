//
//  WebViewController.h
//  Pan Ziyue
//
//  Created by Pan Ziyue on 11/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"

@interface WebViewController : UIViewController <UIWebViewDelegate, NJKWebViewProgressDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshOrStopButton;

-(IBAction)exitNavigationVC:(id)sender;
-(IBAction)refreshOrStopAction:(id)sender;

@end
