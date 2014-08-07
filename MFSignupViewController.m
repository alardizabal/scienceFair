//
//  MFSignupViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/1/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFSignupViewController.h"
#import "MFAPIClient.h"
#import "MFUser.h"
#import "MFDataStore.h"

@interface MFSignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *fullNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmField;
@property (strong, nonatomic) MFDataStore *store;

- (IBAction)signupTapped:(id)sender;

- (IBAction)cancelTapped:(id)sender;

@end

@implementation MFSignupViewController

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
    self.passwordField.secureTextEntry = YES;
    self.passwordConfirmField.secureTextEntry = YES;
    self.store = [MFDataStore sharedStore];
    // Do any additional setup after loading the view.
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

- (IBAction)signupTapped:(id)sender {

    [MFAPIClient createNewUserWithName:self.fullNameField.text Email:self.emailField.text Password:self.passwordField.text PasswordConfirmation:self.passwordConfirmField.text Completion:^(id responseObject) {
        NSDictionary *response = responseObject;
        MFUser *createdUser = [self.store createUser];
        createdUser.name = response[@"name"];
        createdUser.userID = response[@"id"];
        createdUser.token = response[@"token"];
        createdUser.email = response[@"email"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)cancelTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
