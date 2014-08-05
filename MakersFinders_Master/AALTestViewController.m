//
//  AALTestViewController.m
//  InterestsScrollView
//
//  Created by Albert Lardizabal on 7/29/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALTestViewController.h"
#import "AALAPIClient.h"
#import "AALCategory.h"
#import "AALInterest.h"
#import "MFInterest.h"
#import "MFDataStore.h"
#import "MFCategory.h"

@interface AALTestViewController ()

@property (nonatomic) UIScrollView *categoryScrollView;
@property (nonatomic) UIScrollView *interestScrollView;

@property (nonatomic) NSMutableArray *categoryArray;
@property (nonatomic) NSMutableArray *interestsArray;

@property (nonatomic) UIView *containerView;

- (void) showInterests:(NSString *)category;

@end

@implementation AALTestViewController

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
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 568)];
    self.containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];
    
    //    [self.view removeConstraints:self.view.constraints];
    //    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.containerView removeConstraints:self.containerView.constraints];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_containerView);
    //
    //    NSLayoutConstraint *containerViewTopConstraint =
    //    [NSLayoutConstraint constraintWithItem:self.containerView
    //                                 attribute:NSLayoutAttributeTop
    //                                 relatedBy:NSLayoutRelationEqual
    //                                    toItem:self.view
    //                                 attribute:NSLayoutAttributeTop
    //                                multiplier:1.0
    //                                  constant:0.0];
    //    [self.view addConstraint:containerViewTopConstraint];
    
    //    NSArray *topContainerViewVerticalConstraints =
    //    [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_containerView]"
    //                                            options:0
    //                                            metrics:nil
    //                                              views:views];
    //    [self.view addConstraints:topContainerViewVerticalConstraints];
    //
    //    NSArray *topContainerViewHorizontalConstraints =
    //    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_containerView]"
    //                                            options:0
    //                                            metrics:nil
    //                                              views:views];
    //    [self.view addConstraints:topContainerViewHorizontalConstraints];
    
    //        NSArray *containerViewVerticalConstraints =
    //        [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_containerView]|"
    //                                                options:0
    //                                                metrics:nil
    //                                                  views:views];
    //        [self.view addConstraints:containerViewVerticalConstraints];
    //
    //        NSLayoutConstraint *containerViewTopConstraint =
    //        [NSLayoutConstraint constraintWithItem:self.containerView
    //                                     attribute:NSLayoutAttributeTop
    //                                     relatedBy:NSLayoutRelationEqual
    //                                        toItem:self.topLayoutGuide
    //                                     attribute:NSLayoutAttributeBottom
    //                                    multiplier:1.5
    //                                      constant:0.0];
    //        [self.view addConstraint:containerViewTopConstraint];
    
    NSLayoutConstraint *topContainerViewCenterXConstraint =
    [NSLayoutConstraint constraintWithItem:self.containerView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0];
    [self.view addConstraint:topContainerViewCenterXConstraint];
    
    NSLayoutConstraint *topContainerViewYConstraint =
    [NSLayoutConstraint constraintWithItem:self.containerView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:40.0];
    [self.view addConstraint:topContainerViewYConstraint];
    
    NSLayoutConstraint *topContainerViewHeight =
    [NSLayoutConstraint constraintWithItem:self.containerView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1.0
                                  constant:0.0];
    [self.view addConstraint:topContainerViewHeight];
    
    NSLayoutConstraint *topContainerViewWidth =
    [NSLayoutConstraint constraintWithItem:self.containerView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0.0];
    [self.view addConstraint:topContainerViewWidth];
    
    
    self.categoryArray = [[NSMutableArray alloc]init];
    self.interestsArray = [NSMutableArray array];
    
    self.navigationItem.title = @"makersfinders";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName: [UIFont fontWithName:@"NeutraText-BookSC" size:25.0f]
                                                                    };
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45/255.0 green:62/255.0 blue:81/255.0 alpha:1];
    
    
    UILabel *followYourInterestsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    followYourInterestsLabel.text = @"Follow your interests:";
    followYourInterestsLabel.accessibilityLabel = @"Follow your interests";
    followYourInterestsLabel.font = [UIFont boldSystemFontOfSize:12];
    followYourInterestsLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:followYourInterestsLabel];
    
//    [self stageData];
    [self showCategories];
}

- (void) stageData
{
    
    //    AALInterest *interest1 = [[AALInterest alloc]initWithInterestName:@"Yoga" interestImage:[UIImage imageNamed:@"times_square"]];
    //    AALInterest *interest2 = [[AALInterest alloc]initWithInterestName:@"Juices" interestImage:[UIImage imageNamed:@"times_square"]];
    //    AALInterest *interest3 = [[AALInterest alloc]initWithInterestName:@"Herbs" interestImage:[UIImage imageNamed:@"times_square"]];
    //    AALInterest *interest4 = [[AALInterest alloc]initWithInterestName:@"Bodywork" interestImage:[UIImage imageNamed:@"times_square"]];
    //
    //    AALCategory *category1 = [[AALCategory alloc]initWithCategoryName:@"Health & Wellness" categoryImage:[UIImage imageNamed:@"times_square"] interests:@[interest1, interest2, interest3, interest4]];
    //
    //    AALInterest *interest5 = [[AALInterest alloc]initWithInterestName:@"Hiking" interestImage:[UIImage imageNamed:@"times_square"]];
    //    AALInterest *interest6 = [[AALInterest alloc]initWithInterestName:@"Mountaineering" interestImage:[UIImage imageNamed:@"times_square"]];
    //    AALInterest *interest7 = [[AALInterest alloc]initWithInterestName:@"Fishing" interestImage:[UIImage imageNamed:@"times_square"]];
    //    AALInterest *interest8 = [[AALInterest alloc]initWithInterestName:@"Boating" interestImage:[UIImage imageNamed:@"times_square"]];
    //    AALInterest *interest9 = [[AALInterest alloc]initWithInterestName:@"Biking" interestImage:[UIImage imageNamed:@"times_square"]];
    //    AALInterest *interest10 = [[AALInterest alloc]initWithInterestName:@"Camping" interestImage:[UIImage imageNamed:@"times_square"]];
    //
    //    AALCategory *category2 = [[AALCategory alloc]initWithCategoryName:@"Outdoors" categoryImage:[UIImage imageNamed:@"times_square"] interests:@[interest5, interest6, interest7, interest8, interest9, interest10]];
    
    
    //    NSOperationQueue *apiDownloader = [[NSOperationQueue alloc]init];
    //    apiDownloader.maxConcurrentOperationCount = 10;
    
    //    AFHTTPRequestOperation *getImageOperation = [[AFHTTPRequestOperation alloc]initWithRequest:imageRequest];
    
    [AALAPIClient getCategoryImagesWithCompletion:^(NSDictionary *dictionary) {
        
        for (NSDictionary *category in dictionary) {
            
            AALCategory *tempCategory = [[AALCategory alloc]init];
            tempCategory.categoryName = category[@"name"];
            tempCategory.interests = [[NSMutableArray alloc]init];
            
            NSString *tempImageURLString = category[@"images"][@"retina"];
            tempCategory.categoryImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tempImageURLString]]];
            
            NSArray *interestDictionary = category[@"categories"];
            
            for (NSUInteger i = 0; i < [interestDictionary count]; i++) {
                
                AALInterest *tempInterest = [[AALInterest alloc]init];
                
                NSString *tempImageURLString = interestDictionary[i][@"images"][@"retina"];
                
                tempInterest.interestName = interestDictionary[i][@"name"];
                tempInterest.interestImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tempImageURLString]]];
                
                [tempCategory.interests addObject:tempInterest];
            }
            
            [self.categoryArray addObject:tempCategory];
        }
        
        [self showCategories];
    }];
    
}

- (void) showCategories
{
    
    NSUInteger categoryViewWidth = 160;
    NSUInteger categoryViewHeight = 200;
    NSUInteger startXvalueScrollView = 80;
    NSUInteger categoryPadding = 20;
    
    MFDataStore *store = [MFDataStore sharedStore];
    NSFetchRequest *fetchCategories = [[NSFetchRequest alloc] initWithEntityName:@"MFCategory"];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    fetchCategories.sortDescriptors = @[sortByName];
    self.categoryArray = [store.context executeFetchRequest:fetchCategories error:nil];

    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [self.categoryArray count] * (categoryViewWidth + categoryPadding), categoryViewHeight)];
    
    for (NSUInteger i = 0; i < [self.categoryArray count]; i++) {

        MFCategory *tempCategory = self.categoryArray[i];
        
        UIView *categoryContainerView = [[UIView alloc]initWithFrame:CGRectMake(startXvalueScrollView, 0, categoryViewWidth, categoryViewHeight)];
        
        UIImageView *categorySelectedHighlight = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 170, 170)];
        categorySelectedHighlight.backgroundColor = [UIColor colorWithRed:0 green:119.0/255.0 blue:126.0/255.0 alpha:1.0];
        
        categorySelectedHighlight.layer.cornerRadius = categorySelectedHighlight.frame.size.height/2;
        categorySelectedHighlight.clipsToBounds = YES;
        categorySelectedHighlight.accessibilityLabel = @"Category Highlight";
        categorySelectedHighlight.hidden = YES;
        
        UIImageView *categoryImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 150, 150)];
//        UIImage *categoryImage = tempCategory.categoryImage;
        
        categoryImageView.layer.cornerRadius = categoryImageView.frame.size.height/2;
        categoryImageView.clipsToBounds = YES;
        
        UIImage *image = [self getImageWithName:tempCategory.name];
        [categoryImageView setImage:image];
        
        [categoryContainerView addSubview:categorySelectedHighlight];
        [categoryContainerView addSubview:categoryImageView];
        
        categoryContainerView.accessibilityLabel = tempCategory.name;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCategoryTap:)];
        [categoryContainerView addGestureRecognizer:tapRecognizer];
        
        [contentView addSubview:categoryContainerView];
        
        UILabel *categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 175, categoryContainerView.frame.size.width, 20)];
        categoryLabel.text = tempCategory.name;
        categoryLabel.font = [UIFont boldSystemFontOfSize:12];
        categoryLabel.textColor = [UIColor colorWithRed:0 green:119.0/255.0 blue:126.0/255.0 alpha:1.0];
        categoryLabel.textAlignment = NSTextAlignmentCenter;
        [categoryContainerView addSubview:categoryLabel];
        
        startXvalueScrollView += categoryViewWidth + categoryPadding;
    }
    
    self.categoryScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 25, 320, categoryViewHeight)];
    
    //    self.categoryScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    //
    //    NSDictionary *nameMap = @{@"categoryScrollView" : self.categoryScrollView,
    //                              @"interestScrollView" : self.interestScrollView};
    //
    //    NSArray *verticalConstraintCategoryScrollView = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[categoryScrollView]-"
    //                                                                                            options:0
    //                                                                                            metrics:nil
    //                                                                                              views:nameMap];
    //    [self.view addConstraints:verticalConstraintCategoryScrollView];
    
    self.categoryScrollView.accessibilityLabel = @"Category Scrollview";
    self.categoryScrollView.scrollEnabled = YES;
    self.categoryScrollView.showsHorizontalScrollIndicator = NO;
    self.categoryScrollView.contentSize = CGSizeMake([self.categoryArray count] * (categoryViewWidth + categoryPadding) + 140, categoryViewHeight);
    
    [self.categoryScrollView addSubview:contentView];
    [self.containerView addSubview:self.categoryScrollView];
}

- (void) showInterests:(NSString *)category
{
    // 0 119 126
    
    NSUInteger startXvalueScrollView = 0;
    NSUInteger interestPadding = 5;
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [self.categoryArray count] * (100 + interestPadding), 150)];
    
    for (NSUInteger i = 0; i < [self.categoryArray count]; i++) {

        MFCategory *tempCategory = self.categoryArray[i];
        
        if ([tempCategory.name isEqualToString:category]) {
            self.interestsArray = [tempCategory.interests allObjects];
            
            for (NSUInteger i = 0; i < [self.interestsArray count]; i++) {
                
                UIView *interestContainerView = [[UIView alloc]initWithFrame:CGRectMake(startXvalueScrollView, 0, 100, 150)];
                UIImageView *interestImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
                UIImageView *selectedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
                
                MFInterest *tempInterest = self.interestsArray[i];
//                UIImage *interestImage = tempInterest.interestImage;
                
                interestImageView.layer.cornerRadius = interestImageView.frame.size.height/2;
                interestImageView.clipsToBounds = YES;
                
//                [interestImageView setImage:interestImage];
                UIImage *image = [self getImageWithName:tempInterest.name];
                [interestImageView setImage:image];
                [interestContainerView addSubview:interestImageView];
                
                [selectedImageView setImage:[UIImage imageNamed:@"checkmark"]];
                selectedImageView.accessibilityLabel = @"Interest Highlight";
                selectedImageView.layer.cornerRadius = selectedImageView.frame.size.height/2;
                selectedImageView.clipsToBounds = YES;
                selectedImageView.hidden = YES;
                [interestContainerView addSubview:selectedImageView];
                
                interestContainerView.accessibilityLabel = tempInterest.name;
                
                UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleInterestTap:)];
                [interestContainerView addGestureRecognizer:tapRecognizer];
                
                [contentView addSubview:interestContainerView];
                
                UILabel *interestLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, interestContainerView.frame.size.width, 20)];
                interestLabel.text = tempInterest.name;
                interestLabel.font = [UIFont boldSystemFontOfSize:10];
                interestLabel.textColor = [UIColor colorWithRed:0 green:119.0/255.0 blue:126.0/255.0 alpha:1.0];
                interestLabel.textAlignment = NSTextAlignmentCenter;
                [interestContainerView addSubview:interestLabel];
                
                startXvalueScrollView += 100 + interestPadding;
                
            }
            
        }
        
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 230, 320, 150)];
    scrollView.accessibilityLabel = category;
    scrollView.scrollEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake([self.interestsArray count] * (100 + interestPadding), 150);
    
    [scrollView addSubview:contentView];
    [self.containerView addSubview:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleCategoryTap:(UITapGestureRecognizer *)recognizer
{
    NSString *categoryTapped = recognizer.view.accessibilityLabel;
    
    NSLog(@"%@", self.containerView.subviews);
    
    for (UIView *tempView in self.containerView.subviews) {
        
        NSString *tempViewClass = (NSString *)tempView.class;
        
        NSLog(@"%@ %@", tempView.accessibilityLabel, tempViewClass);
        
        if ([tempView isKindOfClass:[UIScrollView class]]) {
            if (![tempView.accessibilityLabel isEqualToString:@"Category Scrollview"] && ![tempView.accessibilityLabel isEqualToString:@"Follow your interests"])
            {
                tempView.hidden = YES;
            }
        }
    }
    
    for (UIView *selectedView in recognizer.view.subviews) {
        if ([selectedView.accessibilityLabel isEqualToString:@"Category Highlight"] ) {
            
            if (selectedView.hidden == YES) {
                selectedView.hidden = NO;
            } else {
                selectedView.hidden = YES;
            }
        }
    }
    
    [self showInterests:categoryTapped];
}

- (void)handleInterestTap:(UITapGestureRecognizer *)recognizer
{
    NSString *interestTapped = recognizer.view.accessibilityLabel;
    
    for (UIView *selectedView in recognizer.view.subviews) {
        if ([selectedView.accessibilityLabel isEqualToString:@"Interest Highlight"] ) {
            if (selectedView.hidden == YES) {
                selectedView.hidden = NO;
            } else {
                selectedView.hidden = YES;
            }
        }
    }
    
    NSLog(@"%@", interestTapped);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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

-(UIImage *)getImageWithName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *fixedString = [name stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fixedString];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    return image;
}

@end