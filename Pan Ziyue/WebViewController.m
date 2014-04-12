//
//  WebViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 11/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "WebViewController.h"
#import "NJKWebViewProgressView.h"
#import "TLAlertView.h"

@interface WebViewController ()
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    
    bool errorBool;
}

@end

@implementation WebViewController


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
    
    errorBool=false;
    
    // Initialize NJKWebViewProgress
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _mainWebView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.5f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    
    if ([self.urlString isEqualToString:@"https://statixind.net/about.html"]) {
        self.title = @"StatiX Industries";
    }
    else if ([self.urlString isEqualToString:@"http://www.sst.edu.sg"]) {
        self.title = @"SST";
    }
    
    // Start loading
    [_mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    
    UIBarButtonItem *bttn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopLoading)];
    self.navigationItem.rightBarButtonItem = bttn;
}

-(void)refresh
{
    [_mainWebView reload];
}

-(void)stopLoading
{
    [_mainWebView stopLoading];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(IBAction)exitNavigationVC:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    errorBool=true;
    if (error.code!=-999) {
        TLAlertView *alert = [[TLAlertView alloc]initWithTitle:@"Error loading!" message:@"Please check your Internet connection." buttonTitle:@"Got it"];
        [alert show];
        errorBool=false;
    }
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress==0.0f) {
        UIBarButtonItem *bttn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopLoading)];
        self.navigationItem.rightBarButtonItem = bttn;
    }
    else if (progress==1.0f) { // finished loading
        UIBarButtonItem *bttn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
        self.navigationItem.rightBarButtonItem = bttn;
    }
    
    [_progressView setProgress:progress animated:YES];
    self.navigationItem.prompt = [_mainWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
