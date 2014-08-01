//
//  MFAppDelegate.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 7/30/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFAppDelegate.h"
#import "MFCustomTabBarControllerViewController.h"
#import "MFLoginViewController.h"

@implementation MFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MFLoginViewController *loginVC = [main instantiateViewControllerWithIdentifier:@"login"];
    UINavigationController *loginNavvc = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = loginNavvc;
    
//    MFCustomTabBarControllerViewController *rootTabBarController = [[MFCustomTabBarControllerViewController alloc] init];
//    self.window.rootViewController = rootTabBarController;
    [application setStatusBarHidden:NO];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    statusBarView.backgroundColor = [UIColor colorWithRed:45/255.0 green:62/255.0 blue:81/255.0 alpha:1];
    [self.window.rootViewController.view addSubview:statusBarView];
                             
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
