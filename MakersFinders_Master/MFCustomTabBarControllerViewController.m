//
//  MFCustomTabBarControllerViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 7/30/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFCustomTabBarControllerViewController.h"
#import "MFUploadRootViewController.h"
#import "MFExploreRootViewController.h"
#import "AALTestViewController.h"
#import "FISFeedTableViewController.h"
#import "MPSProfileViewController.h"
#import "MFLoginViewController.h"

@interface MFCustomTabBarControllerViewController ()
@property (nonatomic) BOOL loggedIn;
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
    UIStoryboard *alMain = [UIStoryboard storyboardWithName:@"AALMain" bundle:nil];
    UIStoryboard *mattMain = [UIStoryboard storyboardWithName:@"Main_Matt" bundle:nil];
    
    
    self.tabBar.layer.borderWidth = 0.50;
    self.tabBar.layer.borderColor = self.tabBarController.tabBar.tintColor.CGColor;
    
    
    //    UIStoryboard *detail = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    //    FISFeedTableViewController *vc1 = [detail instantiateViewControllerWithIdentifier:@"feed"];
    FISFeedTableViewController *vc1 = [[FISFeedTableViewController alloc] init];
    UINavigationController *navvc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    MFExploreRootViewController *vc2 = [main instantiateViewControllerWithIdentifier:@"exploreRoot"];
    UINavigationController *navvc2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    MFUploadRootViewController *vc3 = [main instantiateViewControllerWithIdentifier:@"uploadRoot"];
    UINavigationController *navvc3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    
    AALTestViewController *vc4 = [main instantiateViewControllerWithIdentifier:@"notificationsFollowing"];
    UINavigationController *navvc4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    
    MPSProfileViewController *vc5 = [mattMain instantiateViewControllerWithIdentifier:@"profileRoot"];
    UINavigationController *navvc5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    self.viewControllers = @[navvc1, navvc2, navvc3, navvc4, navvc5];
    
    UITabBarItem *item0 = [self.tabBar.items objectAtIndex:0];
    item0.image = [UIImage imageNamed:@"home.png"];
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
    item3.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    //    item3.title = @"Notifications";
    
    UITabBarItem *item4 = [self.tabBar.items objectAtIndex:4];
    item4.image = [UIImage imageNamed:@"user.png"];
    item4.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    item4.title = @"";
    
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
