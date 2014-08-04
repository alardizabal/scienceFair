//
//  MPSProfileViewController.m
//  MakersFindersUserProfile
//
//  Created by matt on 7/30/14.
//  Copyright (c) 2014 mpsauce. All rights reserved.
//

#import "MPSProfileViewController.h"
#import "FISDataStore.h"
#import "FlickrPhoto.h"

@interface MPSProfileViewController ()

@property (strong, nonatomic) CIContext *context;
@property (weak, nonatomic) IBOutlet UIView *headerContainerView;
@property (weak, nonatomic) IBOutlet UIView *makerContainerView;
@property (weak, nonatomic) IBOutlet UIView *findContainerView;
@property (strong, nonatomic) NSString *userImageURL;
- (IBAction)makerIsTapped:(id)sender;
@property (strong, nonatomic) NSString *userHeaderURL;
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
    
    
    
    
    
    //this sets the profil image properties to be a radial view.
    //    self.profileImageView.bounds
    //if square image is 100 then the corner radius is (divided) / 2
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    //this clips the bounds of the radius
    self.profileImageView.clipsToBounds = YES;
    //this sets the border thickness
    self.profileImageView.layer.borderWidth = 3.0f;
    //this sets the border color
    self.profileImageView.layer.borderColor = [UIColor colorWithRed:0.0 green:80.0/255.0 blue:86.0/255.0 alpha:1.0].CGColor;
    
    
    
    //will set a profile picture if one exists. If not, then set default picure
    //    if (self.user.profilePicture) {
    //        self.userImageURL = self.user.profilePicture;
    //    } else {
    //        self.userImageURL = @"link/to/default.png";
    //    }
    self.userImageURL = @"http://media-cache-ak0.pinimg.com/236x/e3/d9/b7/e3d9b77c19a3bcce0f2ac43428018a83.jpg";
    
    //    if (self.user.headerPicture) {
    //        self.userHeaderURL = self.user.headerPicture;
    //    } else {
    //        self.userHeaderURL = self.userImageURL;
    //    }
  self.userHeaderURL = self.userImageURL;
//    [self.userHeaderURL stringByAppendingString:self.userImageURL];
//    NSLog(@"%@", self.userHeaderURL);
    
    self.profileImageView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:self.userImageURL]]];
    
    self.headerImageView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:self.userHeaderURL]]];
    
    
    
    
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
    // headerImage = [CIImage imageWithColor:[CIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    
    NSMutableArray *imagePositions = [[NSMutableArray alloc]init];
    [imagePositions addObject:[NSValue valueWithCGRect:CGRectMake(0, 0, 155, 155)]];
    [imagePositions addObject:[NSValue valueWithCGRect:CGRectMake(0, 157, 51, 51)]];
    [imagePositions addObject:[NSValue valueWithCGRect:CGRectMake(52, 157, 51, 51)]];
    [imagePositions addObject:[NSValue valueWithCGRect:CGRectMake(104, 157, 51, 51)]];
    

    NSMutableArray *makerImageViews = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i<4; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:[imagePositions[i] CGRectValue]];
        image.contentMode = UIViewContentModeScaleAspectFill;
        [image setClipsToBounds:YES];
        [makerImageViews addObject:image];
        [self.makerContainerView addSubview:image];
    }
    
    NSMutableArray *findsImageViews = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i<4; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:[imagePositions[i] CGRectValue]];
        image.contentMode = UIViewContentModeScaleAspectFill;
        [image setClipsToBounds:YES];
        [findsImageViews addObject:image];
        [self.findContainerView addSubview:image];
    }
    
    
    
    FISDataStore *store = [FISDataStore sharedDataStore];
    [store flickrFeedImages:^(NSArray *flickrPhotosArray) {
        for (NSInteger i = 0; i<4; i++) {
            UIImageView *makerImageView = makerImageViews[i];
            FlickrPhoto *flickrmake = store.flickrPhotoFeed[i];

            UIImageView *findsImageView = findsImageViews[i];
            FlickrPhoto *flickrfind = store.flickrPhotoFeed[i+4];

            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                makerImageView.image = flickrmake.thumbnail;
                findsImageView.image = flickrfind.thumbnail;
            }];
        }
    }];
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

- (IBAction)followButton:(id)sender {
}
- (IBAction)makerIsTapped:(id)sender {
}
@end
