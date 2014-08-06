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
#import "MFBackground.h"



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

    [MFBackground LoadCategoryAndInterestImagesInBackGround];

    
    
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



@end