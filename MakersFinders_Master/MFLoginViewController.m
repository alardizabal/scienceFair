//
//  MFLoginViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 7/31/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFLoginViewController.h"
#import "MFAPIClient.h"
#import "MFCustomTabBarControllerViewController.h"
#import "AALAPIClient.h"
#import "MFDataStore.h"
#import "MFUser.h"
#import "MFCategory.h"
#import "MFInterest.h"

@interface MFLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;


@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UILabel *MakersFindersLogo;
@property (weak, nonatomic) IBOutlet UIView *loginButton;

@end

@implementation MFLoginViewController

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
    
    NSOperationQueue *imageFetchingQueue = [[NSOperationQueue alloc] init];
    MFDataStore *store = [MFDataStore sharedStore];
    
    [imageFetchingQueue addOperationWithBlock:^{
        [AALAPIClient getCategoryImagesWithCompletion:^(NSDictionary *dictionary) {
            for (NSDictionary *category in dictionary) {
                
                NSString *name = category[@"name"];
                NSString *tempImageURLString = category[@"images"][@"retina"];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tempImageURLString]]];
                NSString *path = [self saveImage:image WithName:name];
                MFCategory *category = [store createCategory];
                category.name = name;
                category.imageURL = path;
            }
        }];
    }];
    
    self.navigationController.navigationBarHidden = YES;
    self.passwordField.secureTextEntry = YES;
    
    self.emailField.delegate = self;
    self.passwordField.delegate = self;
    
    self.bottomContainer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginMainImage"]];
    self.MakersFindersLogo.text = @"MakersFinders";
    self.MakersFindersLogo.font = [UIFont fontWithName:@"NeutraText-BookSC" size:40];
    self.MakersFindersLogo.textColor = [UIColor whiteColor];
    self.MakersFindersLogo.shadowColor = [UIColor blackColor];
    self.MakersFindersLogo.shadowOffset = CGSizeMake(1,1);
    self.loginButton.layer.cornerRadius = 6.0f;
    
    UITapGestureRecognizer *loginTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginTapped:)];
    [self.loginButton addGestureRecognizer:loginTapped];
    
    

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
-(void)loginTapped:(UITapGestureRecognizer *)recognizer
{
    MFAPIClient *client = [[MFAPIClient alloc] init];
    [client loginNewUserWithEmail:@"dansundsun@gmail.com" Password:@"test" Completion:^{
        MFCustomTabBarControllerViewController *tabBarController = [[MFCustomTabBarControllerViewController alloc] init];
        [self.navigationController pushViewController:tabBarController animated:YES];
    }];
}

-(NSString *)saveImage: (UIImage*)image WithName:(NSString *)name;
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithFormat: @"%@",name]];
    NSData* data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
    return path;
}

@end