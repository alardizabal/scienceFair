//
//  AALTestViewController.m
//  InterestsScrollView
//
//  Created by Albert Lardizabal on 7/29/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALTestViewController.h"
#import "AALCategory.h"
#import "AALInterest.h"

@interface AALTestViewController ()

@property (nonatomic) NSArray *categoryArray;
@property (nonatomic) NSArray *interestsArray;

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
    // Do any additional setup after loading the view.
    
    UILabel *followYourInterestsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 20)];
    followYourInterestsLabel.text = @"Follow your interests:";
    followYourInterestsLabel.accessibilityLabel = @"Follow your interests";
    followYourInterestsLabel.font = [UIFont boldSystemFontOfSize:12];
    followYourInterestsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:followYourInterestsLabel];
    
    [self stageData];
    [self showCategories];
    
}

- (void) stageData
{
    
    AALInterest *interest1 = [[AALInterest alloc]initWithInterestName:@"Yoga" interestImage:[UIImage imageNamed:@"times_square"]];
    AALInterest *interest2 = [[AALInterest alloc]initWithInterestName:@"Juices" interestImage:[UIImage imageNamed:@"times_square"]];
    AALInterest *interest3 = [[AALInterest alloc]initWithInterestName:@"Herbs" interestImage:[UIImage imageNamed:@"times_square"]];
    AALInterest *interest4 = [[AALInterest alloc]initWithInterestName:@"Bodywork" interestImage:[UIImage imageNamed:@"times_square"]];
    
    AALCategory *category1 = [[AALCategory alloc]initWithCategoryName:@"Health & Wellness" categoryImage:[UIImage imageNamed:@"times_square"] interests:@[interest1, interest2, interest3, interest4]];
    
    AALInterest *interest5 = [[AALInterest alloc]initWithInterestName:@"Hiking" interestImage:[UIImage imageNamed:@"times_square"]];
    AALInterest *interest6 = [[AALInterest alloc]initWithInterestName:@"Mountaineering" interestImage:[UIImage imageNamed:@"times_square"]];
    AALInterest *interest7 = [[AALInterest alloc]initWithInterestName:@"Fishing" interestImage:[UIImage imageNamed:@"times_square"]];
    AALInterest *interest8 = [[AALInterest alloc]initWithInterestName:@"Boating" interestImage:[UIImage imageNamed:@"times_square"]];
    AALInterest *interest9 = [[AALInterest alloc]initWithInterestName:@"Biking" interestImage:[UIImage imageNamed:@"times_square"]];
    AALInterest *interest10 = [[AALInterest alloc]initWithInterestName:@"Camping" interestImage:[UIImage imageNamed:@"times_square"]];
    
    AALCategory *category2 = [[AALCategory alloc]initWithCategoryName:@"Outdoors" categoryImage:[UIImage imageNamed:@"times_square"] interests:@[interest5, interest6, interest7, interest8, interest9, interest10]];
    
    self.categoryArray = [[NSArray alloc]initWithObjects:category1, category2, category1, category2, nil];
    
}

- (void) showCategories
{
    
    NSUInteger categoryViewWidth = 160;
    NSUInteger categoryViewHeight = 200;
    NSUInteger startXvalueScrollView = 80;
    NSUInteger categoryPadding = 20;
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [self.categoryArray count] * (categoryViewWidth + categoryPadding), categoryViewHeight)];
    
    for (NSUInteger i = 0; i < [self.categoryArray count]; i++) {
        AALCategory *tempCategory = [[AALCategory alloc]init];
        tempCategory = self.categoryArray[i];
        
        UIView *categoryContainerView = [[UIView alloc]initWithFrame:CGRectMake(startXvalueScrollView, 0, categoryViewWidth, categoryViewHeight)];
        
        UIImageView *categorySelectedHighlight = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 170, 170)];
        categorySelectedHighlight.backgroundColor = [UIColor colorWithRed:0 green:119.0/255.0 blue:126.0/255.0 alpha:1.0];
        
        categorySelectedHighlight.layer.cornerRadius = categorySelectedHighlight.frame.size.height/2;
        categorySelectedHighlight.clipsToBounds = YES;
        categorySelectedHighlight.accessibilityLabel = @"Category Highlight";
        categorySelectedHighlight.hidden = YES;
        
        UIImageView *categoryImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 150, 150)];
        UIImage *categoryImage = tempCategory.categoryImage;
        
        categoryImageView.layer.cornerRadius = categoryImageView.frame.size.height/2;
        categoryImageView.clipsToBounds = YES;
        
        [categoryImageView setImage:categoryImage];
        
        [categoryContainerView addSubview:categorySelectedHighlight];
        [categoryContainerView addSubview:categoryImageView];
        
        categoryContainerView.accessibilityLabel = tempCategory.categoryName;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCategoryTap:)];
        [categoryContainerView addGestureRecognizer:tapRecognizer];
        
        [contentView addSubview:categoryContainerView];
        
        UILabel *categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 175, categoryContainerView.frame.size.width, 20)];
        categoryLabel.text = tempCategory.categoryName;
        categoryLabel.font = [UIFont boldSystemFontOfSize:12];
        categoryLabel.textColor = [UIColor colorWithRed:0 green:119.0/255.0 blue:126.0/255.0 alpha:1.0];
        categoryLabel.textAlignment = NSTextAlignmentCenter;
        [categoryContainerView addSubview:categoryLabel];
        
        startXvalueScrollView += categoryViewWidth + categoryPadding;
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 150, 320, categoryViewHeight)];
    scrollView.accessibilityLabel = @"Category Scrollview";
    scrollView.scrollEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake([self.categoryArray count] * (categoryViewWidth + categoryPadding), categoryViewHeight);
    
    [scrollView addSubview:contentView];
    [self.view addSubview:scrollView];
}

- (void) showInterests:(NSString *)category
{
    // 0 119 126
    
    NSUInteger startXvalueScrollView = 0;
    NSUInteger interestPadding = 5;
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [self.categoryArray count] * (100 + interestPadding), 150)];
    
    for (NSUInteger i = 0; i < [self.categoryArray count]; i++) {
        AALCategory *tempCategory = [[AALCategory alloc]init];
        tempCategory = self.categoryArray[i];
        
        if ([tempCategory.categoryName isEqualToString:category]) {
            self.interestsArray = tempCategory.interests;
            
            for (NSUInteger i = 0; i < [self.interestsArray count]; i++) {
                
                UIView *interestContainerView = [[UIView alloc]initWithFrame:CGRectMake(startXvalueScrollView, 0, 100, 150)];
                UIImageView *interestImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
                UIImageView *selectedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
                
                AALInterest *tempInterest = self.interestsArray[i];
                UIImage *interestImage = tempInterest.interestImage;
                
                interestImageView.layer.cornerRadius = interestImageView.frame.size.height/2;
                interestImageView.clipsToBounds = YES;
                
                [interestImageView setImage:interestImage];
                [interestContainerView addSubview:interestImageView];
                
                [selectedImageView setImage:[UIImage imageNamed:@"checkmark"]];
                selectedImageView.accessibilityLabel = @"Interest Highlight";
                selectedImageView.layer.cornerRadius = selectedImageView.frame.size.height/2;
                selectedImageView.clipsToBounds = YES;
                selectedImageView.hidden = YES;
                [interestContainerView addSubview:selectedImageView];
                
                interestContainerView.accessibilityLabel = tempInterest.interestName;
                
                UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleInterestTap:)];
                [interestContainerView addGestureRecognizer:tapRecognizer];
                
                [contentView addSubview:interestContainerView];
                
                UILabel *interestLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, interestContainerView.frame.size.width, 20)];
                interestLabel.text = tempInterest.interestName;
                interestLabel.font = [UIFont boldSystemFontOfSize:12];
                interestLabel.textColor = [UIColor colorWithRed:0 green:119.0/255.0 blue:126.0/255.0 alpha:1.0];
                interestLabel.textAlignment = NSTextAlignmentCenter;
                [interestContainerView addSubview:interestLabel];
                
                startXvalueScrollView += 100 + interestPadding;
                
            }
            
        }
        
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 375, 320, 150)];
    scrollView.accessibilityLabel = category;
    scrollView.scrollEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake([self.interestsArray count] * (100 + interestPadding), 150);
    
    [scrollView addSubview:contentView];
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleCategoryTap:(UITapGestureRecognizer *)recognizer
{
    NSString *categoryTapped = recognizer.view.accessibilityLabel;
    
    NSLog(@"%@", self.view.subviews);
    
    for (UIView *tempView in self.view.subviews) {
        
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

@end
