//
//  MFUploadRootViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 7/30/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//


//THIS SCREEN HAS TO BE AUTOLAYOUTED! 8/5/14

#import "MFUploadRootViewController.h"
#import "MFDataStore.h"
#import "AALTestViewController.h"

@interface MFUploadRootViewController ()
@property (weak, nonatomic) IBOutlet UIView *rightButton;
@property (weak, nonatomic) IBOutlet UIView *leftButton;
@property (weak, nonatomic) IBOutlet UILabel *topTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *madeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *foundTextLabel;

@property (strong, nonatomic) NSMutableArray *images;


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
    self.images = [[NSMutableArray alloc] init];
    //NavigationBar Setup
    self.navigationItem.title = @"Upload";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: MFmenuFont
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
    
    
    //View Setup
    self.view.backgroundColor = MFdarkTealColor;
    
    self.leftButton.layer.cornerRadius = self.leftButton.frame.size.height/2;
    self.leftButton.clipsToBounds = YES;
    
    self.rightButton.layer.cornerRadius = self.rightButton.frame.size.height/2;
    self.rightButton.clipsToBounds = YES;
    
    self.leftButton.backgroundColor = MFtealColor;
    self.rightButton.backgroundColor = MFtealColor;
    
    self.topTextLabel.textColor = [UIColor whiteColor];
    self.topTextLabel.font = MFhelveticaUploadScreen;
    self.topTextLabel.text = @"What would you like to upload?";
    
    self.madeTextLabel.textColor = [UIColor whiteColor];
    self.madeTextLabel.font = MFhelveticaUploadScreen;
    self.madeTextLabel.text = @"I made this"; //eventually make this bold in the middle
    
    self.foundTextLabel.textColor = [UIColor whiteColor];
    self.foundTextLabel.font = MFhelveticaUploadScreen;
    self.foundTextLabel.text = @"I found this"; //eventually make this bold in the middle
    
    //Add tap recognition to two buttons
    UITapGestureRecognizer *madeThisTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMadeButtonTapped:)];
    [self.leftButton addGestureRecognizer:madeThisTapped];
    
    UITapGestureRecognizer *foundThisTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleFoundButtonTapped:)];
    [self.rightButton addGestureRecognizer:foundThisTapped];
    

    // Do any additional setup after loading the view.
}

-(void)peopleButtonTapped:(UITapGestureRecognizer *)recognizer
{
    
}

-(void)heartButtonTapped:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *alMain = [UIStoryboard storyboardWithName:@"AALMain" bundle:nil];
    AALTestViewController *vc1 = [alMain instantiateViewControllerWithIdentifier:@"interests"];
    UINavigationController *navvc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    navvc1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navvc1 animated:YES completion:nil];
}

-(void)handleMadeButtonTapped:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *marcusStoryBoard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    UIViewController *tempVC = [marcusStoryBoard instantiateViewControllerWithIdentifier:@"madeUpload"];
    [self presentViewController:tempVC animated:YES completion:nil];
}

-(void)handleFoundButtonTapped:(UITapGestureRecognizer *)recognizer
{
    UIStoryboard *marcusStoryBoard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    UIViewController *tempVC2 = [marcusStoryBoard instantiateViewControllerWithIdentifier:@"foundUpload"];
    [self presentViewController:tempVC2 animated:YES completion:nil];
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

//- (IBAction)tempTest:(id)sender {
//    MFDataStore *store = [MFDataStore sharedStore];
//    NSFetchRequest *fetchCategories = [[NSFetchRequest alloc] initWithEntityName:@"MFCategory"];
//    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//    fetchCategories.sortDescriptors = @[sortByName];
//    NSArray *categories = [store.context executeFetchRequest:fetchCategories error:nil];
//    NSLog(@"%d",[categories count]);
//
//    
//    for (MFCategory *category in categories)
//    {
//        UIImage *image = [self loadImageWithPathName:category.imageURL];
//        [self.images addObject:image];
//        self.imageView.image = image;
//    }
//    NSLog(@"%d", [self.images count]);
//}
//
//- (UIImage*)loadImageWithPathName: (NSString *)pathName
//{
//    NSData *pngData = [NSData dataWithContentsOfFile:pathName];
//    UIImage *image = [UIImage imageWithData:pngData];
//    
//    return image;
//}


@end
