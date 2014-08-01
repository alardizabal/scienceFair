//
//  FISFeedTableViewController.m
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/28/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "FISFeedTableViewController.h"
#import "FISDataStore.h"
#import "FISPug.h"
#import "FISCustomPugCell.h"
#import "UITabBarController+hideMeh.h"
#import "FISProductDetailViewController.h"
//Delete after feed test data is finished
#import "FlickrPhoto.h"

@interface FISFeedTableViewController ()

@end

@implementation FISFeedTableViewController {
    
    CGFloat startContentOffset;
    CGFloat lastContentOffset;
    BOOL hidden;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //Custom initialization
        hidden = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    static NSString *CellIdentifier = @"pugCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"FISCustomPugCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier];

    self.navigationItem.title = @"Your Curated Feed";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName: [UIFont fontWithName:@"NeutraText-BookSC" size:25.0f]
                                                                    };
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45/255.0 green:62/255.0 blue:81/255.0 alpha:1];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.store = [FISDataStore sharedDataStore];
    [self.store flickrFeedImages:^{
        [self.tableView reloadData];
    }];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self.tabBarController setTabBarHidden:hidden animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.store.flickrPhotoFeed count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FISCustomPugCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pugCell" forIndexPath:indexPath];
    
    FlickrPhoto *eachPhoto = self.store.flickrPhotoFeed[indexPath.row];
    cell.pugCellImageView.image = eachPhoto.thumbnail;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.tabBarController setTabBarHidden:NO animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIStoryboard *productDetailStoryboard = [UIStoryboard storyboardWithName:@"Detail" bundle:[NSBundle mainBundle]];
    FISProductDetailViewController *productDetailVC = [productDetailStoryboard instantiateViewControllerWithIdentifier:@"productDetailVC"];
    productDetailVC.flickrPhoto = self.store.flickrPhotoFeed[indexPath.row];
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

#pragma mark - Hiding the nav/tab controllers

-(void)expand
{
    if (hidden) {
        return;
    }
    
    hidden = YES;
    
//    [self.tabBarController setTabBarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)contract
{
    if (!hidden) {
        return;
    }
    
    hidden = NO;
    
//    [self.tabBarController setTabBarHidden:NO animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    startContentOffset = lastContentOffset = scrollView.contentOffset.y;
    //NSLog(@"scrollViewWillBeginDragging: %f", scrollView.contentOffset.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat differenceFromStart = startContentOffset - currentOffset;
    CGFloat differenceFromLast = lastContentOffset - currentOffset;
    lastContentOffset = currentOffset;
    
    
    
    if((differenceFromStart) < 0)
    {
        // scroll up
        if(scrollView.isTracking && (abs(differenceFromLast)>1))
            [self expand];
    }
    else {
        if(scrollView.isTracking && (abs(differenceFromLast)>1))
            [self contract];
    }
    
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [self contract];
    return YES;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
