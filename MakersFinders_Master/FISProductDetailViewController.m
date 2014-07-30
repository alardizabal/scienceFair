//
//  FISProductDetailViewController.m
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/29/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "FISProductDetailViewController.h"
#import "UITabBarController+hideMeh.h"
#import "FISPug.h"

@interface FISProductDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageOfInterest;
@property (weak, nonatomic) IBOutlet UILabel *shortDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfLikesLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *hashtagsLabel;


@end

@implementation FISProductDetailViewController

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
    CGRect frame = CGRectMake(100, 0, 400, 44);
    UILabel *titleOfNavigationItem = [[UILabel alloc] initWithFrame:frame];
    titleOfNavigationItem.backgroundColor = [UIColor clearColor];
    titleOfNavigationItem.font = [UIFont fontWithName:@"Avenir Light" size:22.0];
    titleOfNavigationItem.textColor = [UIColor whiteColor];
    titleOfNavigationItem.textAlignment = NSTextAlignmentCenter;
    titleOfNavigationItem.text = @"makersfinders";
    [titleOfNavigationItem sizeToFit];
    self.navigationItem.titleView = titleOfNavigationItem;
    
    self.profileImage.layer.cornerRadius = 25.0;
    self.profileImage.layer.masksToBounds = YES;
    
    self.mainImageOfInterest.image = self.pugWithImage.pugImage;
    
    [self.tabBarController setTabBarHidden:NO animated:YES]; 
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
