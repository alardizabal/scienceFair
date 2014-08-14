//
//  FISFeedTableViewController.m
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/28/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "FISFeedTableViewController.h"
#import "FISCustomPugCell.h"
#import "FISProductDetailViewController.h"
#import "AALInterestsViewController.h"
#import "MFDataStore.h"
#import "MFAPIClient.h"
#import "MFItem.h"
#import "MFBackground.h"
#import "MFUser.h"

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
                                                                    NSFontAttributeName:MFmenuFont};
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45/255.0 green:62/255.0 blue:81/255.0 alpha:1];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"peoplebutton"] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(peopleButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"heartbutton"] forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, 22, 25);
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [rightButton addTarget:self action:@selector(heartButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.store = [MFDataStore sharedStore];
    self.arrayOfItemsObjects = [NSMutableArray new];
    [self placeHolderImages];
    
    //Downloading on background queue of images
    [MFAPIClient retrieveFeedAPIImages:^(BOOL success, NSArray *responseObjectArray) {
        if (success) {
            for (NSInteger i=0; i<[responseObjectArray count]; i++) {
                //Grab each item
                NSDictionary *responseDictionary = responseObjectArray[i];

                //Download image
                NSString *urlOfImage = responseDictionary[@"images"][@"retina"];
                
                NSURL *retinaImageURL = [NSURL URLWithString:urlOfImage];
                NSData *retinaImageDataToBeDownloaded = [NSData dataWithContentsOfURL:retinaImageURL];
                UIImage *retinaImage = [UIImage imageWithData:retinaImageDataToBeDownloaded];
                
                //Cache image in NSDocumentsDirectory
                MFItem *eachItem = [self.store createItem];
                eachItem.uniqueID = responseDictionary[@"id"];
                NSString *uniqueIdentifer = [NSString stringWithFormat:@"item%@", eachItem.uniqueID];
                
                [MFBackground saveImage:retinaImage WithName:uniqueIdentifer];
                
                //Add image to array to be displayed in FeedTVC
                [self.arrayOfFeedImages replaceObjectAtIndex:i withObject:retinaImage];
            }
            //Refresh tableView
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
            NSLog(@"Success!");
        }
    }];
    
    //Creating MFItem objects from data retrieval
    [MFAPIClient retrieveFeedAPIImages:^(BOOL success, NSArray *responseObjectArray) {
        if (success) {
            for (NSInteger i=0; i<[responseObjectArray count]; i++) {
                //Grab each item
                NSDictionary *responseDictionary = responseObjectArray[i];
                
                MFItem *eachItem = [self.store createItem];
                //Make MFItem from data retrieval
                eachItem.uniqueID = responseDictionary[@"id"];
                eachItem.name = responseDictionary[@"name"];
                eachItem.itemType = responseDictionary[@"make_or_find"];
                eachItem.loves = responseDictionary[@"favorites_count"];
                //Get user info for item
//                eachItem.user = [MFUser currentUser];
//                eachItem.user = [self.store createUser];
//                eachItem.user.uniqueID = responseDictionary[@"user"][@"id"];
//                eachItem.user.profileImageURL = responseDictionary[@"user"][@"images"][@"thumb_retina"];
//                eachItem.user.name = responseDictionary[@"user"][@"name"];
                eachItem.imageURL = [MFBackground getNameOfImageURLWithName:[NSString stringWithFormat:@"item%@",eachItem.uniqueID]];
                
                [self.arrayOfItemsObjects addObject:eachItem];
            
            }
        }
    }];
    
}

-(void)peopleButtonTapped:(UITapGestureRecognizer *)recognizer
{
    
}

-(void)heartButtonTapped:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *alMain = [UIStoryboard storyboardWithName:@"AALMain" bundle:nil];
    AALInterestsViewController *vc1 = [alMain instantiateViewControllerWithIdentifier:@"interests"];
    UINavigationController *navvc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    navvc1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navvc1 animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)placeHolderImages
{
    self.arrayOfFeedImages = [NSMutableArray new];
    for (NSInteger i=0; i<45; i++)
    {
        UIImage *placeHolderImage = [UIImage imageNamed:@"placeholder.png"];
        [self.arrayOfFeedImages addObject:placeHolderImage];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayOfFeedImages count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FISCustomPugCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pugCell" forIndexPath:indexPath];
    
    UIImage *eachPlaceholderImage = self.arrayOfFeedImages[indexPath.row];
    cell.pugCellImageView.image = eachPlaceholderImage;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *productDetailStoryboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    FISProductDetailViewController *productDetailVC = [productDetailStoryboard instantiateViewControllerWithIdentifier:@"productDetailVC"];
//    MFItem *currentItem = self.arrayOfItemsObjects[indexPath.row];
//    productDetailVC.currentItem = currentItem;
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

#pragma mark UIScrollViewDelegate Methods

//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
//{
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    return YES;
//}

#pragma mark - Navigation hide methods

//-(void)expand
//{
//    if(hidden)
//        return;
//    
//    hidden = YES;
//    
//    //    [self.tabBarController setTabBarHidden:YES
//    //                                  animated:YES];
//    
//    [self.navigationController setNavigationBarHidden:YES
//                                             animated:YES];
//}
//
//-(void)contract
//{
//    if(!hidden)
//    {
//        return;
//    }
//    
//    hidden = NO;
//    
//    //    [self.tabBarController setTabBarHidden:NO
//    //                                  animated:YES];
//    
//    [self.navigationController setNavigationBarHidden:NO
//                                             animated:YES];
//}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    startContentOffset = lastContentOffset = scrollView.contentOffset.y;
//    //NSLog(@"scrollViewWillBeginDragging: %f", scrollView.contentOffset.y);
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat currentOffset = scrollView.contentOffset.y;
//    CGFloat differenceFromStart = startContentOffset - currentOffset;
//    CGFloat differenceFromLast = lastContentOffset - currentOffset;
//    lastContentOffset = currentOffset;
//    
//    NSLog(@"Offest: %f",currentOffset);
//    NSLog(@"start: %f", differenceFromStart);
//    NSLog(@"last: %f",differenceFromLast);
//    
//    if((differenceFromStart) < 0)
//    {
//        // scroll up
//        if(scrollView.isTracking && (abs(differenceFromLast)>20))
//        {
//            [self expand];
//            NSLog(@"Expanding");
//        }
//    }
//    else {
//        if(scrollView.isTracking && (abs(differenceFromLast)>20))
//        {
//            [self contract];
//            NSLog(@"contracting");
//        }
//    }
//    
//}

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
