//
//  MenuViewController.m
//  Pan Ziyue
//
//  Created by Pan Ziyue on 9/4/14.
//  Copyright (c) 2014 StatiX Industries. All rights reserved.
//

#import "MenuViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "NavigationViewController.h"
#import <MediaPlayer/MediaPlayer.h>

// Import all other view controllers here
#import "ViewController.h"
#import "AboutMeViewController.h"
#import "SkillsViewController.h"
#import "CompanyViewController.h"
#import "EducationViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        NSMutableArray *images = [[NSMutableArray alloc] init];
        //NSArray *imageNames = @[@"img_5582.jpg", @"img_5587.jpg", @"img_5592.jpg", @"img_5597.jpg", @"img_5602.jpg", @"img_5607.jpg", @"img_5612.jpg", @"img_5617.jpg", @"img_5622.jpg", @"img_5627.jpg", @"img_5632.jpg", @"img_5637.jpg", @"img_5642.jpg", @"img_5647.jpg", @"img_5652.jpg", @"img_5657.jpg", @"img_5662.jpg", @"img_5667.jpg"];
        NSArray *imageNames = @[@"img_5582.jpg", @"img_5584.jpg", @"img_5587.jpg", @"img_5589.jpg", @"img_5592.jpg", @"img_5594.jpg", @"img_5597.jpg", @"img_5599.jpg", @"img_5602.jpg", @"img_5604.jpg", @"img_5607.jpg", @"img_5609.jpg", @"img_5612.jpg", @"img_5614.jpg", @"img_5617.jpg", @"img_5619.jpg", @"img_5622.jpg", @"img_5624.jpg", @"img_5627.jpg", @"img_5629.jpg", @"img_5632.jpg", @"img_5634.jpg", @"img_5637.jpg", @"img_5639.jpg", @"img_5642.jpg", @"img_5644.jpg", @"img_5647.jpg", @"img_5649.jpg", @"img_5652.jpg", @"img_5654.jpg", @"img_5657.jpg", @"img_5659.jpg", @"img_5662.jpg", @"img_5664.jpg", @"img_5667.jpg", @"img_5669.jpg"];
        //NSArray *imageNames = @[@"img_5582.jpg"];
        
        for (int i = 0; i < imageNames.count; i++) {
            [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
        }
        imageView.animationImages=images;
        imageView.animationDuration=3.0f;
        
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text = @"Pan Ziyue";
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [imageView startAnimating];
        [view addSubview:label];
        view;
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    if (sectionIndex == 0)
        return nil;
    else if (sectionIndex == 1)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
        label.text = @"My Projects";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        [view addSubview:label];
    }
    else
    {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
        label1.text = @"Credits";
        label1.font = [UIFont systemFontOfSize:15];
        label1.textColor = [UIColor whiteColor];
        label1.backgroundColor = [UIColor clearColor];
        [label1 sizeToFit];
        [view addSubview:label1];
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NavigationViewController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    if (indexPath.section==0) // First section
    {
        if (indexPath.row==0) {
            ViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeController"];
            navigationController.viewControllers = @[homeViewController];
        }
        else if (indexPath.row==1) {
            AboutMeViewController *aboutMeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutMeController"];
            navigationController.viewControllers = @[aboutMeViewController];
        }
        else if (indexPath.row==2) {
            SkillsViewController *skillsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"skillsViewController"];
            navigationController.viewControllers = @[skillsViewController];
        }
        else if (indexPath.row==3) {
            CompanyViewController *companyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"companyViewController"];
            navigationController.viewControllers=@[companyVC];
        }
        else if (indexPath.row==4) {
            EducationViewController *educationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"educationViewController"];
            navigationController.viewControllers=@[educationVC];
        }
    }
    else if (indexPath.section==1) // My projects section
    {
        if (indexPath.row==0) { // Announcer
            
        }
        else if (indexPath.row==1) { // Lens
            
        }
        else if (indexPath.row==2) { //HexBT
            
        }
    }
    else if (indexPath.section==2) // Credits section
    {
        if (indexPath.row==0) { // Acknowledgements
            
        }
        else if (indexPath.row==1) { // Makings
            
        }
    }
    
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    //return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (sectionIndex==0) {
        return 5;
    }
    else if (sectionIndex==1) {
        return 3;
    }
    /*else if (sectionIndex==2) {
        return 2;
    }*/
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles = @[@"Home", @"Who I am", @"Skills & Experience", @"My Company", @"My Education"];
        cell.textLabel.text = titles[indexPath.row];
    } else if (indexPath.section == 1) {
        NSArray *titles = @[@"SST Announcer", @"SST Lens", @"HexBT"];
        cell.textLabel.text = titles[indexPath.row];
    } else if (indexPath.section == 2) {
        NSArray *titles = @[@"Acknowledgements", @"The Makings of this App"];
        cell.textLabel.text = titles[indexPath.row];
    }
    
    return cell;
}

@end
