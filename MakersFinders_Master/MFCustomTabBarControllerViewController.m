//
//  MFCustomTabBarControllerViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 7/30/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFCustomTabBarControllerViewController.h"
#import "MFUploadRootViewController.h"
#import "FISFeedTableViewController.h"

@interface MFCustomTabBarControllerViewController ()

@end

@implementation MFCustomTabBarControllerViewController

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
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FISFeedTableViewController *vc1 = [[FISFeedTableViewController alloc] init];
    UINavigationController *navvc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    UIViewController *vc2 = [main instantiateViewControllerWithIdentifier:@"temp"];
    
    MFUploadRootViewController *vc3 = [main instantiateViewControllerWithIdentifier:@"uploadRoot"];
    UINavigationController *navvc3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    
    UIViewController *vc4 = [main instantiateViewControllerWithIdentifier:@"temp"];
    UIViewController *vc5 = [main instantiateViewControllerWithIdentifier:@"temp"];
    self.viewControllers = @[navvc1, vc2, navvc3, vc4, vc5];
    

    UITabBarItem *item0 = [self.tabBar.items objectAtIndex:0];
    item0.image = [UIImage imageNamed:@"home.png"];
    item0.selectedImage = [UIImage imageNamed:@"home_selected"];
    item0.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
//    item0.title = @"Home";
    
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:1];
    item1.image = [UIImage imageNamed:@"search.png"];
    item1.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
//    item1.title = @"Search";
    
    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:2];
    item2.image = [UIImage imageNamed:@"upload.png"];
    item2.selectedImage = [UIImage imageNamed:@"upload_selected"];
    item2.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);

//    item2.title = @"Upload";
    
    UITabBarItem *item3 = [self.tabBar.items objectAtIndex:3];
    item3.image = [UIImage imageNamed:@"notifications.png"];
    item3.selectedImage = [UIImage imageNamed:@"notifications_selected"];
    item3.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);

//    item3.title = @"Notifications";
    
    UITabBarItem *item4 = [self.tabBar.items objectAtIndex:4];
    item4.image = [UIImage imageNamed:@"user.png"];
    item4.selectedImage = [UIImage imageNamed:@"user_selected"];
    item4.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);

//    item4.title = @"Profile";
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbarbackground"];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [UIColor colorWithRed:2/225.0 green:211/225.0 blue:224/225.0 alpha:1];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
