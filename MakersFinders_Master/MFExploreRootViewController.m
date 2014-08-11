//
//  MFExploreRootViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 7/31/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFExploreRootViewController.h"
#import "MFExploreCustomTableViewCell.h"
#import "MFDataStore.h"
#import "MFInterestsFeedTableViewController.h"
#import "MFSecretViewController.h"
#import "MFAPIClient.h"
#import "MFInterest.h"
#import "MFBackground.h"
#import "AALInterestsViewController.h"


@interface MFExploreRootViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *makersFindersButton;
@property (weak, nonatomic) IBOutlet UIView *collectivesButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchField;
@property (weak, nonatomic) IBOutlet UILabel *makersLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectivesLabel;
@property (weak, nonatomic) IBOutlet UIView *collectivesView;

@property (strong, nonatomic) NSMutableArray *recentSearchesArray;
@property (strong, nonatomic) NSMutableArray *categoryImagesArray;
@property (strong, nonatomic) NSMutableArray *categoryNamesArray;
@property (nonatomic) NSInteger counter;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) UIGestureRecognizer *getOutOfSearchTap;

@property (strong, nonatomic) NSMutableArray *interests;

@end

@implementation MFExploreRootViewController

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchField.delegate = self;

    self.collectivesView.hidden = YES;
    self.interests = [[NSMutableArray alloc] init];
    
    //adding placeholder images and then getting appropriate images
    
    MFDataStore *store = [MFDataStore sharedStore];
    NSFetchRequest *fetchInterests = [[NSFetchRequest alloc] initWithEntityName:@"MFInterest"];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"uniqueID" ascending:YES];
    fetchInterests.sortDescriptors = @[sortByName];
//    NSArray *interestsArray = [store.context executeFetchRequest:fetchInterests error:nil];
    [self.interests addObjectsFromArray:[store.context executeFetchRequest:fetchInterests error:nil]];
    
//    for (NSInteger i = 0; i<[interestsArray count]; i++)
//    {
//        [self.interests addObject:[UIImage imageNamed:@"placeholder"]];
//    }
    
    
    
    
    
    
    //Navigation Bar Setup (title, font, size, color, translucency)
    self.navigationItem.title = @"Explore";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName: MFmenuFont
                                                                    };
    
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = MFnavBarColor;
    

    
    //Setting up custom buttons on navigation bar
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
    
    
    //Setting up menu button images and text
    self.makersFindersButton.backgroundColor = MFtealColor;
    self.collectivesButton.backgroundColor = MFdarkTealColor;
    self.makersLabel.font = MFhelvetica;
    self.makersLabel.text = @"MakersFinders";
    self.makersLabel.textColor = [UIColor whiteColor];
    
    self.collectivesLabel.font = MFhelvetica;
    self.collectivesLabel.text = @"Collectives";
    self.collectivesLabel.textColor = [UIColor whiteColor];
    
    self.searchField.placeholder = @"Search Categories";

    
    //Add tap gesture recognizers to the two menu items: Makers & Finder and Collectives.

    UITapGestureRecognizer *tapRecognizerForMakersFindersButton = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleMakersFindersButtonTapped:)];
    [self.makersFindersButton addGestureRecognizer:tapRecognizerForMakersFindersButton];
    
    UITapGestureRecognizer *tapRecognizerForCollectivesButton = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCollectivesButtonTapped:)];
    [self.collectivesButton addGestureRecognizer:tapRecognizerForCollectivesButton];
    
//    //getting categories
//    
//    MFDataStore *store = [MFDataStore sharedStore];
//    NSFetchRequest *categoryFetch = [NSFetchRequest fetchRequestWithEntityName:@"MFCategory"];
//    NSSortDescriptor *categorySort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//    categoryFetch.sortDescriptors = @[categorySort];
//    
//    self.fetchedResultsController.delegate = self;
//    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:categoryFetch managedObjectContext:store.context sectionNameKeyPath:nil cacheName:nil];
//    [self.fetchedResultsController performFetch:nil];
//    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardDidHideNotification object:nil];
    
    
    
}



-(void)peopleButtonTapped:(UITapGestureRecognizer *)recognizer
{
    
}

-(void)keyboardDidShow
{
    self.getOutOfSearchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleScreenTapped:)];
    [self.view addGestureRecognizer:self.getOutOfSearchTap];
}

-(void)keyboardDidHide
{
    [self.view removeGestureRecognizer:self.getOutOfSearchTap];
}


-(void)handleScreenTapped:(UITapGestureRecognizer *)recognizer
{
    [self.searchField resignFirstResponder];
}

-(void)heartButtonTapped:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *alMain = [UIStoryboard storyboardWithName:@"AALMain" bundle:nil];
    AALInterestsViewController *vc1 = [alMain instantiateViewControllerWithIdentifier:@"interests"];
    UINavigationController *navvc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    navvc1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navvc1 animated:YES completion:nil];
}

- (void) dismissKeyboard
{
    // add self
    [self.searchField resignFirstResponder];
}


- (void)handleMakersFindersButtonTapped:(UITapGestureRecognizer *)recognizer
{
    self.makersFindersButton.backgroundColor = MFtealColor;
    self.collectivesButton.backgroundColor = MFdarkTealColor;
    self.collectivesView.hidden = YES;
    self.tableView.hidden = NO;
    self.searchField.placeholder = @"Search Categories";
}

-(void)handleCollectivesButtonTapped:(UITapGestureRecognizer *)recognizer
{
    self.makersFindersButton.backgroundColor = MFdarkTealColor;
    self.collectivesButton.backgroundColor = MFtealColor;
    self.collectivesView.hidden = NO;
    self.tableView.hidden = YES;
    self.searchField.placeholder = @"Search Collectives";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
        //return [self.recentSearch count]
    }
    else
    {
//        return 10;
        return [self.interests count];
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
        return @"Recent Searches";
    else
        return @"All Categories";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MFExploreCustomTableViewCell *exploreCell = [tableView dequeueReusableCellWithIdentifier:@"exploreCell" forIndexPath:indexPath];
    
    [self tableView:tableView heightForRowAtIndexPath:indexPath];
    if (indexPath.section == 0)
    {
        MFInterest *interest = self.interests[indexPath.row];
        UIImage *image = [MFBackground getImageWithUniqueIdentifier:interest.imageURL];
        exploreCell.categoryImage.image = image;
        exploreCell.categoryLabel.text = @"Recent Search";
    }
    else if (indexPath.section == 1)
    {
        MFInterest *interest = self.interests[indexPath.row];
        UIImage *image = [MFBackground getImageWithUniqueIdentifier:interest.imageURL];
        exploreCell.categoryImage.image = image;
        exploreCell.categoryLabel.text = interest.name;
    }
    
    return exploreCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFInterestsFeedTableViewController *interestsFeedVC = [[MFInterestsFeedTableViewController alloc] init];
    interestsFeedVC.currentInterest = self.interests[indexPath.row];
    [self.navigationController pushViewController:interestsFeedVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([searchBar.text isEqualToString:@"1337"])
    {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MFSecretViewController *secretvc = [main instantiateViewControllerWithIdentifier:@"secret"];
        [self presentViewController:secretvc animated:NO completion:nil];
    }
    else
    {
        [searchBar resignFirstResponder];
    }
}


//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    
//}


@end
