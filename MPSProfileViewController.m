//
//  MPSProfileViewController.m
//  MakersFindersUserProfile
//
//  Created by matt on 7/30/14.
//  Copyright (c) 2014 mpsauce. All rights reserved.
//

#import "MPSProfileViewController.h"

@interface MPSProfileViewController ()
@property (strong, nonatomic) CIContext *context;
@end

@implementation MPSProfileViewController

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
    
    self.navigationItem.title = @"Profile";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName: [UIFont fontWithName:@"NeutraText-BookSC" size:25.0f]
                                                                    };
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45/225.0 green:62/225.0 blue:81/225.0 alpha:1];
    
    //this sets the profil image properties to be a radial view.
    //if square image is 100 then the corner radius is (divided) / 2
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    //this clips the bounds of the radius
    self.profileImageView.clipsToBounds = YES;
    //this sets the border thickness
    self.profileImageView.layer.borderWidth = 3.0f;
    //this sets the border color
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    CIImage *headerImage = [[CIImage alloc]initWithImage:[UIImage imageNamed:@"toughcowboy"]];
    
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"
                                      keysAndValues:kCIInputImageKey, headerImage, @"inputRadius", @(3.0), nil];
    CIImage *outputImage = [blurFilter outputImage];
    self.context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [self.context createCGImage:outputImage fromRect: [outputImage extent]];
    self.headerImage.image = [UIImage imageWithCGImage:outImage];
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
