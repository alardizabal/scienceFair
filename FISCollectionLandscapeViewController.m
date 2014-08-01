//
//  FISCollectionLandscapeViewController.m
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/30/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "FISCollectionLandscapeViewController.h"
#import "FISDataStore.h"

@interface FISCollectionLandscapeViewController ()

@end

@implementation FISCollectionLandscapeViewController

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
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.myCollectionView.dataSource = self;
    self.myCollectionView.delegate = self;

    //Registering nib
    UINib *pugCellNib = [UINib nibWithNibName:@"FISPugCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.myCollectionView registerNib:pugCellNib forCellWithReuseIdentifier:@"pugCollectionCell"];
   
    //Setting collectionviewflowlayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(200, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.myCollectionView setCollectionViewLayout:flowLayout];

    self.myCollectionView.backgroundColor = [UIColor colorWithRed:19.0/255.0 green:42.0/255.0 blue:82.0/255.0 alpha:0.5];
    
    [self.view addSubview:self.myCollectionView];
    
    self.store = [FISDataStore sharedDataStore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.store.flickrPhotoFeed count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
//    cell.contentView.i
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50.0, 50.0); 
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
