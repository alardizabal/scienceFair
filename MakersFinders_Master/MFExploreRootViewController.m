//
//  MFExploreRootViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 7/31/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFExploreRootViewController.h"

@interface MFExploreRootViewController ()
@property (weak, nonatomic) IBOutlet UIView *makersFindersButton;
@property (weak, nonatomic) IBOutlet UIView *collectivesButton;
@property (weak, nonatomic) IBOutlet UIImageView *makersFindersImage;
@property (weak, nonatomic) IBOutlet UILabel *makersFindersLabel;
@property (weak, nonatomic) IBOutlet UIImageView *collectivesImage;
@property (weak, nonatomic) IBOutlet UILabel *collectivesLabel;

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
    self.navigationItem.title = @"Explore";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName: [UIFont fontWithName:@"NeutraText-BookSC" size:25.0f]
                                                                    };
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45/225.0 green:62/225.0 blue:81/225.0 alpha:1];
    
    //Setting up menu button images and text
    self.makersFindersButton.backgroundColor = [UIColor colorWithRed:0 green:119/225.0 blue:126/225.0 alpha:1];
    self.makersFindersLabel.text = @"Makers & Finders";
    self.makersFindersImage.image = [UIImage imageNamed:@"explore@2x"];
    
    
    //Add tap gesture recognizers to the two menu items: Makers & Finder and Collectives.
    
    
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
