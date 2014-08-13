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
#import "MFUser.h"
#import "MFDataStore.h"



@interface MFLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UILabel *MakersFindersLogo;
@property (weak, nonatomic) IBOutlet UIView *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;

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
    
    //check to see if there are already images
//    MFDataStore *store = [MFDataStore sharedStore];
//    NSFetchRequest *fetchCategories = [[NSFetchRequest alloc] initWithEntityName:@"MFCategory"];
//    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//    fetchCategories.sortDescriptors = @[sortByName];
//    NSArray *categoriesArray = [store.context executeFetchRequest:fetchCategories error:nil];
    

    [MFBackground LoadCategoryAndInterestImagesInBackGround];
    self.bottomContainer.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationController.navigationBarHidden = YES;
    self.passwordField.secureTextEntry = YES;
    
    self.emailField.delegate = self;
    self.passwordField.delegate = self;
    
    self.MakersFindersLogo.text = @"MakersFinders";
    self.MakersFindersLogo.font = [UIFont fontWithName:@"NeutraText-BookSC" size:40];
    self.topImage.image = [UIImage imageNamed:@"loginMainImage"];
    
    self.MakersFindersLogo.textColor = [UIColor blackColor];
    self.loginButton.layer.cornerRadius = 6.0f;
    
    //added some white space so animation doesn't look weird
    UIView *extraWhiteSpace = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 100)];
    extraWhiteSpace.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:extraWhiteSpace];
    
    
    UITapGestureRecognizer *loginTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginTapped:)];
    [self.loginButton addGestureRecognizer:loginTapped];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

-(void)keyboardWillShow:(NSNotification *)aNotification
{
//    self.bottomContainer.frame = CGRectMake(0,20,self.bottomContainer.frame.size.width,self.bottomContainer.frame.size.height);
//    self.topImage.hidden = YES;
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.bottomContainer.frame;
    frame.origin.y -= self.bottomContainer.frame.size.height *.8;
//    self.topImage.hidden = YES;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.bottomContainer.frame = frame;
    [UIView commitAnimations];


    
}



-(void)keyboardWillHide:(NSNotification *)aNotification
{
//    self.bottomContainer.frame = CGRectMake(0,self.bottomContainer.frame.size.height+20,self.bottomContainer.frame.size.width,self.bottomContainer.frame.size.height);
//    self.topImage.hidden = NO;
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.bottomContainer.frame;
    frame.origin.y += self.bottomContainer.frame.size.height * .8;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.bottomContainer.frame = frame;
    [UIView commitAnimations];
//    self.topImage.hidden = NO;
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

    [MFAPIClient loginNewUserWithEmail:self.emailField.text Password:self.passwordField.text Completion:^(id responseObject) {
        NSDictionary *response = responseObject;
        if (response[@"error"] != nil)
        {
            NSString *errorMessage = @"";
            if([self.emailField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""])
            {
               errorMessage = @"You can't leave a field empty";
            }
            else
            {
                errorMessage = @"You've entered an invalid username/password combination";
            }
            UIAlertView *invalidCredentials = [[UIAlertView alloc] initWithTitle:@"Oops" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [invalidCredentials show];
        }
        else{
            MFDataStore *store = [MFDataStore sharedStore];
            MFUser *createdUser = [store createUser];
            createdUser.name = response[@"name"];
            createdUser.uniqueID = response[@"id"];
            createdUser.token = response[@"token"];
            createdUser.email = response[@"email"];
            
            MFCustomTabBarControllerViewController *tabBarController = [[MFCustomTabBarControllerViewController alloc] init];
            [self.navigationController pushViewController:tabBarController animated:NO];
        }
    }];
}



@end