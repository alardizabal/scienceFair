//
//  MFSecretViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/7/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFSecretViewController.h"
#import "MFDataStore.h"
#import "MFUser.h"

@interface MFSecretViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;
@property (weak, nonatomic) IBOutlet UITextView *userTokenField;
- (IBAction)getOut:(id)sender;

@end

@implementation MFSecretViewController

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
    MFUser *currentUser = [MFUser currentUser];
    
    self.userNameLabel.text = currentUser.name;
    self.userEmailLabel.text = currentUser.email;
    self.userTokenField.text = currentUser.token;
    
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

- (IBAction)getOut:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
