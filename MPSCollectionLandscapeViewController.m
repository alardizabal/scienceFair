//
//  MPSCollectionLandscapeViewController.m
//  MakersFindersUserProfile
//
//  Created by matt on 7/30/14.
//  Copyright (c) 2014 mpsauce. All rights reserved.
//

#import "MPSCollectionLandscapeViewController.h"

@interface MPSCollectionLandscapeViewController ()

@end

@implementation MPSCollectionLandscapeViewController

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
    
//    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
//    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    self.myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
//    [self.myCollectionView setDataSource:self];
//    [self.myCollectionView setDelegate:self];
//    
//    [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
//    [self.myCollectionView setBackgroundColor:[UIColor colorWithRed:19.0/255.0 green:42.0/255.0 blue:82.0/255.0 alpha:0.5]];
//    
//    [self.view addSubview:self.myCollectionView];
//    
    
     // Do any additional setup after loading the view.
}

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 15;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:[indexPath]]
//}

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
