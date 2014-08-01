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

@interface MFLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)loginTapped:(id)sender;

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
    self.navigationController.navigationBarHidden = YES;
    self.passwordField.secureTextEntry = YES;
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

- (IBAction)loginTapped:(id)sender {
    MFAPIClient *client = [[MFAPIClient alloc] init];
    [client loginNewUserWithEmail:self.emailField.text Password:self.passwordField.text Completion:^{
        MFCustomTabBarControllerViewController *tabBarController = [[MFCustomTabBarControllerViewController alloc] init];
        [self.navigationController pushViewController:tabBarController animated:YES];
    }];
}


@end
