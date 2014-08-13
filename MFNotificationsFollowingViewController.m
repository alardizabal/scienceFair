//
//  MFNotificationsFollowingViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/6/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFNotificationsFollowingViewController.h"
#import "AALInterestsViewController.h"
#import "MFNotificationsTableViewCell.h"
#import "MFNotificationsNoImageTableViewCell.h"

@interface MFNotificationsFollowingViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *followingButton;
@property (weak, nonatomic) IBOutlet UIView *newsButton;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *notificationsArray;

@property (strong, nonatomic) NSArray *peopleNames;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *info;
@property (nonatomic) BOOL isOnFollowingView;

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
    self.isOnFollowingView = YES;
    
    
    //Makes extra cells on bottom disappear
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
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
    self.isOnFollowingView = YES;
    [self.tableView reloadData];
}

-(void)handleNewsButtonTapped:(UITapGestureRecognizer *)recognizer
{
    self.followingButton.backgroundColor = MFdarkTealColor;
    self.newsButton.backgroundColor = MFtealColor;
    self.isOnFollowingView = NO;
    [self.tableView reloadData];
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
    AALInterestsViewController *vc1 = [alMain instantiateViewControllerWithIdentifier:@"interests"];
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
    if (self.isOnFollowingView == YES)
        return 3;
    else
        return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    MFNotificationsTableViewCell *notificationsCell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell" forIndexPath:indexPath];
    
    [self tableView:tableView heightForRowAtIndexPath:indexPath];
    
    if (self.isOnFollowingView == YES)
    {
        if (indexPath.row == 0)
        {
            MFNotificationsTableViewCell *notificationsCell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell" forIndexPath:indexPath];
            notificationsCell.profileImage.image = [UIImage imageNamed:@"Dan.png"];
            notificationsCell.nameLabel.text = @"Dan S.";
            notificationsCell.infoLabel.text = @"liked 3 Makes";
            notificationsCell.timeStampLabel.text = @"3h";
            notificationsCell.imageOne.image = [UIImage imageNamed:@"DSimageOne.png"];
            notificationsCell.imageTwo.image = [UIImage imageNamed:@"DSimageTwo.png"];
            notificationsCell.imageThree.image = [UIImage imageNamed:@"DSimageThree.jpg"];
            notificationsCell.imageThree.hidden = NO;
            notificationsCell.imageOne.hidden = NO;
            notificationsCell.imageTwo.hidden = NO;
            return notificationsCell;
            
        }
        else if (indexPath.row == 1)
        {
            MFNotificationsTableViewCell *notificationsCell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell" forIndexPath:indexPath];
            notificationsCell.profileImage.image = [UIImage imageNamed:@"Al.png"];
            notificationsCell.nameLabel.text = @"Al L.";
            notificationsCell.infoLabel.text = @"liked 2 Finds";
            notificationsCell.timeStampLabel.text = @"4h";
            notificationsCell.imageOne.image = [UIImage imageNamed:@"DSimageFour.jpg"];
            notificationsCell.imageTwo.image = [UIImage imageNamed:@"DSimageFive.jpg"];
            notificationsCell.imageThree.hidden = YES;
            notificationsCell.imageOne.hidden = NO;
            notificationsCell.imageTwo.hidden = NO;
            return notificationsCell;
        }
        else
        {
            MFNotificationsTableViewCell *notificationsCell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell" forIndexPath:indexPath];
            notificationsCell.profileImage.image = [UIImage imageNamed:@"Marcus.png"];
            notificationsCell.nameLabel.text = @"Matt S.";
            notificationsCell.infoLabel.text = @"commented on a Make";
            notificationsCell.timeStampLabel.text = @"8h";
            notificationsCell.imageOne.image = [UIImage imageNamed:@"DSImageSix.jpg"];
            notificationsCell.imageThree.hidden = YES;
            notificationsCell.imageOne.hidden = NO;
            notificationsCell.imageTwo.hidden = YES;
            return notificationsCell;
        }
        
    }
    else
    {
        if (indexPath.row == 0)
        {
            MFNotificationsNoImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noImageCell" forIndexPath:indexPath];
            cell.profileImage.image = [UIImage imageNamed:@"Al.png"];
            cell.userLabel.text = @"Dan S.";
            cell.infoLabel.text = @"is following you";
            cell.timeStampLabel.text = @"1h";
            return cell;
        }
        else if (indexPath.row == 1)
        {
            MFNotificationsTableViewCell *notificationsCell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell" forIndexPath:indexPath];
            notificationsCell.profileImage.image = [UIImage imageNamed:@"ray.png"];
            notificationsCell.nameLabel.text = @"Al L.";
            notificationsCell.infoLabel.text = @"commented on your Make";
            notificationsCell.timeStampLabel.text = @"3h";
            notificationsCell.imageOne.image = [UIImage imageNamed:@"DSimageFour.jpg"];
            notificationsCell.imageThree.hidden = YES;
            notificationsCell.imageOne.hidden = NO;
            notificationsCell.imageTwo.hidden = YES;
            return notificationsCell;
        }
        else if (indexPath.row == 2)
        {
            MFNotificationsTableViewCell *notificationsCell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell" forIndexPath:indexPath];
            notificationsCell.profileImage.image = [UIImage imageNamed:@"Dan.png"];
            notificationsCell.nameLabel.text = @"Matt S.";
            notificationsCell.infoLabel.text = @"purchased your Make";
            notificationsCell.timeStampLabel.text = @"6h";
            notificationsCell.imageOne.image = [UIImage imageNamed:@"DSImageSix.jpg"];
            notificationsCell.imageThree.hidden = YES;
            notificationsCell.imageOne.hidden = NO;
            notificationsCell.imageTwo.hidden = YES;
            return notificationsCell;
        }
        else
        {
            MFNotificationsNoImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noImageCell" forIndexPath:indexPath];
            cell.profileImage.image = [UIImage imageNamed:@"Marcus.png"];
            cell.userLabel.text = @"Jay M.";
            cell.infoLabel.text = @"is following you";
            cell.timeStampLabel.text = @"8h";
            return cell;
        }
    }
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
