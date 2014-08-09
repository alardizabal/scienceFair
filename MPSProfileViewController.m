//
//  MPSProfileViewController.m
//  MakersFindersUserProfile
//
//  Created by matt on 7/30/14.
//  Copyright (c) 2014 mpsauce. All rights reserved.
//

#import "MPSProfileViewController.h"
#import "FISFeedTableViewController.h"
#import "AALInterestsViewController.h"
#import "MFAPIClient.h"

@interface MPSProfileViewController ()

@property (strong, nonatomic) CIContext *context;

@property (weak, nonatomic) IBOutlet UIView *headerContainerView;
@property (weak, nonatomic) IBOutlet UIView *makerContainerView;
@property (weak, nonatomic) IBOutlet UIView *findContainerView;
@property (strong, nonatomic) NSString *userImageURL;
@property (strong, nonatomic) NSString *userHeaderURL;

- (IBAction)makerIsTapped:(id)sender;
- (IBAction)finderIsTapped:(id)sender;

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
    
    
    
    self.navigationItem.title = @"makersfinders";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName: [UIFont fontWithName:@"NeutraText-BookSC" size:25.0f]
                                                                    };
    
    self.navigationController.navigationBar.translucent = NO;
    
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
    
    
    
    
    //this sets the profile image properties to be a radial view.
    //if square image is 100 then the corner radius is (divided) / 2
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    //self.profileImageView.layer.cornerRadius = 30.0;
    
    //this clips the bounds of the radius
    self.profileImageView.clipsToBounds = YES;
    
    //this sets the border thickness
    self.profileImageView.layer.borderWidth = 3.0f;
    
    //this sets the border color
    self.profileImageView.layer.borderColor = [UIColor colorWithRed:0.0 green:80.0/255.0 blue:86.0/255.0 alpha:1.0].CGColor;
    
    
    //sets the glow effect filter for profile name and profile job title
    self.profileName.layer.shadowColor = [[UIColor whiteColor] CGColor];
    self.profileName.layer.shadowRadius = 4.0f;
    self.profileName.layer.shadowOpacity = .5;
    self.profileName.layer.shadowOffset = CGSizeZero;
    self.profileName.layer.masksToBounds = NO;
    
    self.profileJobTitle.layer.shadowColor = [[UIColor whiteColor] CGColor];
    self.profileJobTitle.layer.shadowRadius = 4.0f;
    self.profileJobTitle.layer.shadowOpacity = .5;
    self.profileJobTitle.layer.shadowOffset = CGSizeZero;
    self.profileJobTitle.layer.masksToBounds = NO;
    
    
    
    //sets the Gaussian Blur filter on the profile header image view
    CIImage *headerImage = [[CIImage alloc]initWithImage: self.headerImageView.image];
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"
                                      keysAndValues:kCIInputImageKey, headerImage, @"inputRadius", @(3.0), nil];
    CIImage *outputImage = [blurFilter outputImage];
    self.context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [self.context createCGImage:outputImage fromRect: [outputImage extent]];
    self.headerImageView.image = [UIImage imageWithCGImage:outImage];
    
    
    
    
    NSMutableArray *oneImageLayout = [[NSMutableArray alloc] initWithObjects:[NSValue valueWithCGRect:CGRectMake(0, 0, 155, 210)], nil];
    // CGRectMake(0, 0, 155, 210)
    
    NSMutableArray *twoImageLayout = [[NSMutableArray alloc] initWithObjects:[NSValue valueWithCGRect:CGRectMake(0, 0, 155, 105)], [NSValue valueWithCGRect:CGRectMake(0, 105, 155, 105)], nil];
                               
    // 2 images
    // (0, 0, 155, 105)
    // (0,105, 155, 105)
   
    NSMutableArray *threeImageLayout = [[NSMutableArray alloc] initWithObjects:[NSValue valueWithCGRect:CGRectMake(0, 0, 155, 105)], [NSValue valueWithCGRect:CGRectMake(0, 105, 77.5, 105)], [NSValue valueWithCGRect:CGRectMake(77.5, 105, 77.5, 105)], nil];
    
    // 3 images
    // CGRectMake(0, 0, 155, 105)
    // CGRectMake(0, 105, 77.5, 105)
    // CGRectMake(77.5, 105, 77.5, 105)
    
   
    NSMutableArray *fourImageLayout = [[NSMutableArray alloc] initWithObjects:[NSValue valueWithCGRect:CGRectMake(0, 0, 155, 155)], [NSValue valueWithCGRect:CGRectMake(0, 157, 51, 51)], [NSValue valueWithCGRect:CGRectMake(52, 157, 51, 51)], [NSValue valueWithCGRect:CGRectMake(104, 157, 51, 51)], nil];
    // 4 images
    // CGRectMake(0, 0, 155, 155)
    // CGRectMake(0, 157, 51, 51)
    // CGRectMake(52, 157, 51, 51)
    // CGRectMake(104, 157, 51, 51)
    
    
    
    // contains all of the sets of layout arrays
    self.layouts = [[NSMutableArray alloc]initWithObjects:oneImageLayout, twoImageLayout, threeImageLayout, fourImageLayout, nil];
    
    

    [MFAPIClient getUserProfiles:^(NSDictionary *dictionary) {
        
        NSURL *imageURL = [NSURL URLWithString:dictionary[@"images"][@"retina"]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *profileRetinaImage = [UIImage imageWithData:imageData];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            
            
            [self setImages:dictionary[@"makes"] forView: self.makerContainerView];
            [self setImages:dictionary[@"finds"] forView: self.findContainerView];
            self.profileImageView.image = profileRetinaImage;
            self.headerImageView.image = self.profileImageView.image;
        }];
    }];
    
}



-(void)setImages: (NSMutableArray *)images forView:(UIView *)view  {
    
    if ([images count] <=0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:[self.layouts[0][0] CGRectValue]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *defaultImage = [UIImage imageNamed:@"hammer_1"];
        imageView.image = defaultImage;
        [imageView setClipsToBounds:YES];
        [view addSubview:imageView];
        
        return;
    }
    NSUInteger layoutIndex = [images count] >= [self.layouts count] ? [self.layouts count] -1 : [images count] -1;
    NSLog(@"%i",layoutIndex);
    NSMutableArray *imageLayout = [self.layouts objectAtIndex:layoutIndex];
    
    for (NSInteger i = 0; i < [imageLayout count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:[imageLayout[i] CGRectValue]];
        
        NSURL *imageURL = [NSURL URLWithString:images[i][@"images"][@"retina"]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *retinaImage = [UIImage imageWithData:imageData];
        imageView.image = retinaImage;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setClipsToBounds:YES];
        [view addSubview:imageView];

    }
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

- (IBAction)followButton:(id)sender {
}
- (IBAction)makerIsTapped:(id)sender {
    FISFeedTableViewController *feedTVC = [[FISFeedTableViewController alloc]init];
    [self.navigationController pushViewController:feedTVC animated:YES];
}

- (IBAction)finderIsTapped:(id)sender {
    FISFeedTableViewController *feedTVC = [[FISFeedTableViewController alloc]init];
    [self.navigationController pushViewController:feedTVC animated:YES];

}
@end
