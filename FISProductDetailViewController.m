//
//  FISProductDetailViewController.m
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/29/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "FISProductDetailViewController.h"
#import "AALInterestsViewController.h"
#import "MFItem.h"
#import "MFBackground.h"
#import "MFUser.h"

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
    self.navigationItem.title = @"Your Curated Feed";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName: [UIFont fontWithName:@"NeutraText-BookSC" size:25.0f]
                                                                    };
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45/225.0 green:62/225.0 blue:81/225.0 alpha:1];
    
    //Pull image from NSDocumentDirectory
    UIImage *imageToBeDisplayed = [self getImageWithName:self.currentItem.imageURL];
    self.mainImageOfInterest.image = imageToBeDisplayed;
    
    //Not working
    NSURL *profileImageURL = [NSURL URLWithString:self.currentItem.user.profileImageURL];
    NSData *profileImageData = [NSData dataWithContentsOfURL:profileImageURL];
    self.profileImage.image = [UIImage imageWithData:profileImageData];
    
    //Favorites
    self.numberOfLikesLabel.text = [NSString stringWithFormat:@"%@", self.currentItem.loves];
    
    //Name
    self.shortDetailLabel.text = self.currentItem.name;
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

-(UIImage *)getImageWithName:(NSString *)name
{
    NSData *pngData = [NSData dataWithContentsOfFile:name];
    UIImage *image = [UIImage imageWithData:pngData];
    return image;
}

@end
