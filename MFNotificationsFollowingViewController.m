//
//  MFNotificationsFollowingViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/6/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFNotificationsFollowingViewController.h"
#import "AALTestViewController.h"
#import "MFNotificationsTableViewCell.h"

@interface MFNotificationsFollowingViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *followingButton;
@property (weak, nonatomic) IBOutlet UIView *newsButton;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *notificationsArray;

@end

@implementation MFNotificationsFollowingViewController

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
    
    //setupTableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"Notifications";
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
    
    //setup sub menu bar
    self.followingButton.backgroundColor = MFtealColor;
    self.newsButton.backgroundColor = MFdarkTealColor;
    
    self.followingLabel.text = @"Following";
    self.followingLabel.font = MFhelvetica;
    self.followingLabel.textColor = [UIColor whiteColor];
    
    self.newsLabel.text = @"News";
    self.newsLabel.font = MFhelvetica;
    self.newsLabel.textColor = [UIColor whiteColor];
    
    //add tap gestures to sub menu
    UITapGestureRecognizer *tapRecognizerForFollowingButton = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleFollowingButtonTapped:)];
    [self.followingButton addGestureRecognizer:tapRecognizerForFollowingButton];
    
    UITapGestureRecognizer *tapRecognizerForNewsButton = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleNewsButtonTapped:)];
    [self.newsButton addGestureRecognizer:tapRecognizerForNewsButton];
    
}

- (void)handleFollowingButtonTapped:(UITapGestureRecognizer *)recognizer
{
    self.followingButton.backgroundColor = MFtealColor;
    self.newsButton.backgroundColor = MFdarkTealColor;
}

-(void)handleNewsButtonTapped:(UITapGestureRecognizer *)recognizer
{
    self.followingButton.backgroundColor = MFdarkTealColor;
    self.newsButton.backgroundColor = MFtealColor;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)peopleButtonTapped:(UITapGestureRecognizer *)recognizer
{
    
}

-(void)heartButtonTapped:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *alMain = [UIStoryboard storyboardWithName:@"AALMain" bundle:nil];
    AALTestViewController *vc1 = [alMain instantiateViewControllerWithIdentifier:@"interests"];
    UINavigationController *navvc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    navvc1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navvc1 animated:YES completion:nil];
}


//setup TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MFNotificationsTableViewCell *notificationsCell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell" forIndexPath:indexPath];
    
    [self tableView:tableView heightForRowAtIndexPath:indexPath];
    
    
    return notificationsCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    FISFeedTableViewController *feedTVC = [[FISFeedTableViewController alloc]init];
//    [self.navigationController pushViewController:feedTVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
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
