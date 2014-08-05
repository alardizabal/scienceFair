//
//  MFUploadRootViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 7/30/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//


//THIS SCREEN HAS TO BE AUTOLAYOUTED! 8/5/14

#import "MFUploadRootViewController.h"

@interface MFUploadRootViewController ()
@property (weak, nonatomic) IBOutlet UIView *rightButton;
@property (weak, nonatomic) IBOutlet UIView *leftButton;
@property (weak, nonatomic) IBOutlet UILabel *topTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *madeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *foundTextLabel;


@end

@implementation MFUploadRootViewController

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

    //NavigationBar Setup
    self.navigationItem.title = @"Upload";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont fontWithName:@"NeutraText-BookSC" size:25.0f]
                                                            };
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45/255.0 green:62/255.0 blue:81/255.0 alpha:1];
    
    
    //View Setup
    self.view.backgroundColor = MFdarkTealColor;
    
    self.leftButton.layer.cornerRadius = self.leftButton.frame.size.height/2;
    self.leftButton.clipsToBounds = YES;
    
    self.rightButton.layer.cornerRadius = self.rightButton.frame.size.height/2;
    self.rightButton.clipsToBounds = YES;
    
    self.leftButton.backgroundColor = MFtealColor;
    self.rightButton.backgroundColor = MFtealColor;
    
    self.topTextLabel.textColor = [UIColor whiteColor];
    self.topTextLabel.font = MFhelvetica;
    self.topTextLabel.text = @"What would you like to upload?";
    
    self.madeTextLabel.textColor = [UIColor whiteColor];
    self.madeTextLabel.font = MFhelvetica;
    self.madeTextLabel.text = @"I made this"; //eventually make this bold in the middle
    
    self.foundTextLabel.textColor = [UIColor whiteColor];
    self.foundTextLabel.font = MFhelvetica;
    self.foundTextLabel.text = @"I found this"; //eventually make this bold in the middle
    
    //Add tap recognition to two buttons
    UITapGestureRecognizer *madeThisTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMadeButtonTapped:)];
    [self.leftButton addGestureRecognizer:madeThisTapped];
    
    UITapGestureRecognizer *foundThisTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleFoundButtonTapped:)];
    [self.rightButton addGestureRecognizer:foundThisTapped];
    

    // Do any additional setup after loading the view.
}

-(void)handleMadeButtonTapped:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *marcusStoryBoard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    UIViewController *tempVC = [marcusStoryBoard instantiateViewControllerWithIdentifier:@"madeUpload"];
    [self presentViewController:tempVC animated:NO completion:nil];
}

-(void)handleFoundButtonTapped:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *marcusStoryBoard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    UIViewController *tempVC2 = [marcusStoryBoard instantiateViewControllerWithIdentifier:@"foundUpload"];
    [self presentViewController:tempVC2 animated:NO completion:nil];
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
