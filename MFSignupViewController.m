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
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextView *signUpLabel;

@property (strong, nonatomic) UITapGestureRecognizer *getOutOfSearchTap;
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
    
    self.view.backgroundColor = MFtealColor;
    
    self.passwordField.secureTextEntry = YES;
    self.passwordConfirmField.secureTextEntry = YES;
    self.store = [MFDataStore sharedStore];
    
    self.signUpLabel.text = @"Sign up for MakersFinders";
    self.signUpLabel.font = [UIFont fontWithName:@"NeutraText-BookSC" size:30];
    self.signUpLabel.textColor = [UIColor whiteColor];
    self.signUpLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardWillShow:(NSNotification *)aNotification
{
    //    self.bottomContainer.frame = CGRectMake(0,20,self.bottomContainer.frame.size.width,self.bottomContainer.frame.size.height);
    //    self.topImage.hidden = YES;
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.containerView.frame;
    frame.origin.y -= 50;
    //    self.topImage.hidden = YES;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.containerView.frame = frame;
    [UIView commitAnimations];
    
    //add gesture to get out
    self.getOutOfSearchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleScreenTapped:)];
    [self.view addGestureRecognizer:self.getOutOfSearchTap];
    
}

-(void)handleScreenTapped:(UITapGestureRecognizer *)recognizer
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];}

-(void)keyboardWillHide:(NSNotification *)aNotification
{

    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.containerView.frame;
    frame.origin.y += 50;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.containerView.frame = frame;
    [UIView commitAnimations];
    
    //remove tap gesture
    [self.view removeGestureRecognizer:self.getOutOfSearchTap];
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
        createdUser.uniqueID = response[@"id"];
        createdUser.token = response[@"token"];
        createdUser.email = response[@"email"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)cancelTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
