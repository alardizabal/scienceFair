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

@interface MFExploreRootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *makersFindersButton;
@property (weak, nonatomic) IBOutlet UIView *collectivesButton;
@property (weak, nonatomic) IBOutlet UIImageView *collectivesImage;
@property (weak, nonatomic) IBOutlet UIImageView *makersFindersImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchField;


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
}

-(void)peopleButtonTapped:(id)sender
{
    
}

-(void)heartButtonTapped:(id)sender
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
    }
    else
    {
        return 10;
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
    exploreCell.categoryImage.image = [UIImage imageNamed:@"yosemite"];
    exploreCell.categoryLabel.text = @"Yosemite";
    
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
