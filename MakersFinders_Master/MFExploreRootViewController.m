//
//  MFExploreRootViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 7/31/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFExploreRootViewController.h"
#import "MFExploreCustomTableViewCell.h"
#import "AALTestViewController.h"
#import "AALAPIClient.h"

@interface MFExploreRootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *makersFindersButton;
@property (weak, nonatomic) IBOutlet UIView *collectivesButton;
@property (weak, nonatomic) IBOutlet UIImageView *collectivesImage;
@property (weak, nonatomic) IBOutlet UIImageView *makersFindersImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchField;
@property (strong, nonatomic) NSMutableArray *recentSearchesArray;
@property (strong, nonatomic) NSMutableArray *categoryImagesArray;
@property (strong, nonatomic) NSMutableArray *categoryNamesArray;
@property (nonatomic) NSInteger counter;

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
    //Navigation Bar Setup (title, font, size, color, translucency)
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.categoryImagesArray = [[NSMutableArray alloc] init];
    self.categoryNamesArray = [[NSMutableArray alloc] init];
    for (NSInteger x = 0; x<9; x++)
    {
        [self.categoryImagesArray addObject:[UIImage imageNamed:@"categoryImagePlaceholder"]];
        [self.categoryNamesArray addObject:@""];
    }
    
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
    self.makersFindersImage.image = [UIImage imageNamed:@"explore"];
    self.collectivesImage.image = [UIImage imageNamed:@"collectives"];
    
    //Add tap gesture recognizers to the two menu items: Makers & Finder and Collectives.

    UITapGestureRecognizer *tapRecognizerForMakersFindersButton = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleMakersFindersButtonTapped:)];
    [self.makersFindersButton addGestureRecognizer:tapRecognizerForMakersFindersButton];
    
    UITapGestureRecognizer *tapRecognizerForCollectivesButton = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCollectivesButtonTapped:)];
    [self.collectivesButton addGestureRecognizer:tapRecognizerForCollectivesButton];
    
    //Add tap gesture to hide keyboard to get out of search
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    //Calling API for categories
    self.counter = 0;

    [AALAPIClient getCategoryImagesWithCompletion:^(NSDictionary *dictionary) {
        for (NSDictionary *category in dictionary) {
            
            NSString *name = category[@"name"];
            NSString *tempImageURLString = category[@"images"][@"retina"];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tempImageURLString]]];
            
            [self.categoryNamesArray replaceObjectAtIndex:self.counter withObject:name];
            [self.categoryImagesArray replaceObjectAtIndex:self.counter withObject:image];
            
            NSIndexPath *insertIndexpath = [NSIndexPath indexPathForRow:self.counter inSection:1];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadRowsAtIndexPaths:@[insertIndexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
            self.counter ++;
        }
    }];
}

-(void)peopleButtonTapped:(UITapGestureRecognizer *)recognizer
{
    
}

-(void)heartButtonTapped:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *alMain = [UIStoryboard storyboardWithName:@"AALMain" bundle:nil];
    AALTestViewController *vc1 = [alMain instantiateViewControllerWithIdentifier:@"interests"];
    UINavigationController *navvc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
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
}

-(void)handleCollectivesButtonTapped:(UITapGestureRecognizer *)recognizer
{
    self.makersFindersButton.backgroundColor = MFdarkTealColor;
    self.collectivesButton.backgroundColor = MFtealColor;
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
        return [self.categoryNamesArray count];
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
        exploreCell.categoryImage.image = [UIImage imageNamed:@"yosemite"];
        
        exploreCell.categoryLabel.text = @"Recent Search";
    }
    else if (indexPath.section == 1)
    {
        exploreCell.categoryImage.image = self.categoryImagesArray[indexPath.row];
        exploreCell.categoryLabel.text = self.categoryNamesArray[indexPath.row];
    }
    
    return exploreCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
