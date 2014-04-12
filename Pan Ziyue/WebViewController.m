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
    bool refreshOrStop; // refresh=true, stop=false
    
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
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
    
    refreshOrStop=false;
    
    // Initialize NJKWebViewProgress
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _mainWebView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.5f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    
    // Start loading
    [_mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://statixind.net/about.html"]]];
    _refreshOrStopButton.style = UIBarButtonSystemItemStop;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(IBAction)exitNavigationVC:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)refreshOrStopAction:(id)sender
{
    if (refreshOrStop)
        [_mainWebView reload];
    else if (!refreshOrStop)
        [_mainWebView stopLoading];
}

#pragma mark - UIWebView delegates
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    _refreshOrStopButton.style = UIBarButtonSystemItemStop;
    refreshOrStop=false;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    _refreshOrStopButton.style = UIBarButtonSystemItemRefresh;
    refreshOrStop=true;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    TLAlertView *alert = [[TLAlertView alloc]initWithTitle:@"Error loading!" message:@"Please check your Internet connection." buttonTitle:@"Got it"];
    [alert show];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.navigationItem.prompt = [_mainWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
