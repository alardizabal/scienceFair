//
//  MFUploadRootViewController.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 7/30/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFUploadRootViewController.h"

@interface MFUploadRootViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *leftCircle;
@property (weak, nonatomic) IBOutlet UIImageView *rightCircle;

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

    self.navigationItem.title = @"Upload";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont fontWithName:@"NeutraText-BookSC" size:25.0f]
                                                            };
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45/255.0 green:62/255.0 blue:81/255.0 alpha:1];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:80/225.0 blue:86/225.0 alpha:1];
    
    self.leftCircle.layer.cornerRadius = self.leftCircle.frame.size.height/2;
    self.leftCircle.clipsToBounds = YES;
    
    self.rightCircle.layer.cornerRadius = self.rightCircle.frame.size.height/2;
    self.rightCircle.clipsToBounds = YES;
    
    
    
    
    
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

@end
