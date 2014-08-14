//
//  AALTestViewController.m
//  InterestsScrollView
//
//  Created by Albert Lardizabal on 7/29/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//



#import "AALInterestsViewController.h"
#import "MFInterest.h"
#import "MFDataStore.h"
#import "MFCategory.h"
#import "MFAPIClient.h"
#import "MFUser.h"



@interface AALInterestsViewController ()

@property (nonatomic) UIScrollView *categoryScrollView;
@property (nonatomic) UIScrollView *interestScrollView;

@property (nonatomic) NSUInteger categoryWidth;
@property (nonatomic) NSUInteger contentWidth;
@property (nonatomic) NSUInteger currentOffset;
@property (nonatomic) NSUInteger baselineOffset;
@property (nonatomic) NSUInteger currentIndex;

@property (nonatomic) MFUser *currentUser;
@property (nonatomic) UIImageView *categorySelectedHighlight;

@property (nonatomic) NSArray *categoryArray;
@property (nonatomic) NSArray *interestsArray;

@property (nonatomic) UIView *containerView;

@property (nonatomic) NSMutableDictionary *interestKeys;
@property (nonatomic) NSMutableArray *userInterests;

@end



@implementation AALInterestsViewController



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
    
    // Setup Core Data variables
    
    self.currentUser = [MFUser currentUser];
    
    // Set up container views
    //
    // self.containerView -> self.categoryScrollView -> contentView -> categoryContainerView -> categorySelectedHighlight (Color Border)/CategoryImageView/Label
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.center.y - 235, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.containerView.backgroundColor = [UIColor whiteColor];
    
    // Auto layout
    
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.containerView];
    
    
    // Colored border around category image
    
    self.categorySelectedHighlight = [[UIImageView alloc]initWithFrame:CGRectMake(83, 28, 164, 164)];
    self.categorySelectedHighlight.backgroundColor = MFtealColor;
    
    self.categorySelectedHighlight.layer.cornerRadius = self.categorySelectedHighlight.frame.size.height/2;
    self.categorySelectedHighlight.clipsToBounds = YES;
    self.categorySelectedHighlight.accessibilityLabel = @"Category Highlight";
    self.categorySelectedHighlight.hidden = YES;
    
    [self.containerView addSubview:self.categorySelectedHighlight];
    
    NSLog(@"%d", self.categorySelectedHighlight.isHidden);
    
    self.categoryArray = [[NSMutableArray alloc]init];
    self.interestsArray = [[NSMutableArray alloc]init];
    
    
    // Navigation bar
    
    self.navigationItem.title = @"makersfinders";
    
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName: [UIFont fontWithName:@"NeutraText-BookSC" size:25.0f]
                                                                    };
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45/255.0 green:62/255.0 blue:81/255.0 alpha:1];
    
    
    // Label - Follow your interests
    
    UILabel *followYourInterestsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    followYourInterestsLabel.text = @"Follow your interests:";
    followYourInterestsLabel.accessibilityLabel = @"Follow your interests";
    followYourInterestsLabel.font = [UIFont boldSystemFontOfSize:12];
    followYourInterestsLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.containerView addSubview:followYourInterestsLabel];

    
    // Toolbar
    
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 20 - 44 - 44, self.view.bounds.size.width, 44)];

    toolbar.backgroundColor = [UIColor grayColor];

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC:)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:nil action:nil];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolbar.items = [NSArray arrayWithObjects:cancelButton, flexibleSpace, doneButton, nil];
    
    [self.view addSubview:toolbar];
    

    // Generate interest key dictionary from ALL interests
    
    self.interestKeys = [[NSMutableDictionary alloc]init];

    [MFAPIClient getCategoryImagesWithCompletion:^(NSDictionary *dictionary) {
        
        for (NSDictionary *eachCategory in dictionary) {
            
            NSArray *interestsArray = eachCategory[@"categories"];
            
            for (NSDictionary *interestDictionary in interestsArray) {
                
                id interestId = interestDictionary[@"id"];
                
                NSString *interestName = interestDictionary[@"name"];
                

                [self.interestKeys setValue:interestId forKey:interestName];
                
            }
        }
        
        NSLog(@"%@", self.interestKeys);
    }];
    
    
    
    // Generate interest key dictionary for USER

    self.userInterests = [NSMutableArray array];
    
    [MFAPIClient getUserInterestsWithCompletion:^(NSArray *array) {
        
        for (NSDictionary *dictionary in array) {
            
            [self.userInterests addObject:dictionary[@"id"]];
            
        }
        
        NSLog(@"%@", array);
        NSLog(@"%@", self.userInterests);

    }];
    
    [self showCategories];

    self.contentWidth = self.categoryScrollView.contentSize.width;

}



- (IBAction)dismissVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void) showCategories

{
    self.categoryWidth = 160;
    NSUInteger categoryViewHeight = 200;
    NSUInteger startXvalueScrollView = 80;
    
    
    // Retrieve from Core Data
    
    MFDataStore *store = [MFDataStore sharedStore];
    
    
    // Show categories alphabetically

    NSFetchRequest *fetchCategories = [[NSFetchRequest alloc] initWithEntityName:@"MFCategory"];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    fetchCategories.sortDescriptors = @[sortByName];
    
    self.categoryArray = [store.context executeFetchRequest:fetchCategories error:nil];

    // self.containerView -> self.categoryScrollView -> contentView -> categoryContainerView -> categorySelectedHighlight (Color Border)/CategoryImageView/Label
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [self.categoryArray count] * (self.categoryWidth * 2), categoryViewHeight)];
    
    for (NSUInteger i = 0; i < [self.categoryArray count]; i++) {

        MFCategory *tempCategory = self.categoryArray[i];
        UIView *categoryContainerView = [[UIView alloc]initWithFrame:CGRectMake(startXvalueScrollView, 0, self.categoryWidth, categoryViewHeight)];

        // Category image

        UIImageView *categoryImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 150, 150)];
        categoryImageView.layer.cornerRadius = categoryImageView.frame.size.height/2;
        categoryImageView.clipsToBounds = YES;

        UIImage *image = [self getImageWithName:tempCategory.name];

        [categoryImageView setImage:image];
        [categoryContainerView addSubview:categoryImageView];
        categoryContainerView.accessibilityLabel = tempCategory.name;
        [contentView addSubview:categoryContainerView];
        
        // Category Title Label

        UILabel *categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 175, categoryContainerView.frame.size.width, 20)];
        
        categoryLabel.text = tempCategory.name;
        categoryLabel.font = [UIFont boldSystemFontOfSize:12];
        categoryLabel.textColor = MFtealColor;
        categoryLabel.textAlignment = NSTextAlignmentCenter;
        [categoryContainerView addSubview:categoryLabel];

        // Category width is used twice for padding between categories.

        startXvalueScrollView += self.categoryWidth * 2;
        
    }

    // Set up scroll view

    self.categoryScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 25, 320, categoryViewHeight)];

    
    // Scroll view delegate is needed for the scrollViewDidScroll method
    
    self.categoryScrollView.delegate = self;
    
    self.categoryScrollView.accessibilityLabel = @"Category Scrollview";
    self.categoryScrollView.scrollEnabled = YES;
    self.categoryScrollView.showsHorizontalScrollIndicator = NO;
    self.categoryScrollView.contentSize = CGSizeMake([self.categoryArray count] * (self.categoryWidth * 2), categoryViewHeight);
    
    [self.categoryScrollView addSubview:contentView];
    [self.containerView addSubview:self.categoryScrollView];
    self.categoryScrollView.pagingEnabled = YES;
    
    [self showInterestsAtIndex:0];

}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView

{
    self.currentOffset = scrollView.contentOffset.x;
    self.baselineOffset = self.contentWidth/[self.categoryArray count];
    
    if (self.currentOffset == 0) {

        self.currentIndex = 0;
        
        MFCategory *tempCategory = self.categoryArray[self.currentIndex];
        
        NSLog(@"%@", tempCategory.name);
        
        [self showInterestsAtIndex:self.currentIndex];

    } else if (self.currentOffset % self.baselineOffset == 0){

        self.currentIndex = self.currentOffset / self.baselineOffset;
        
        NSLog(@"Current Category Index %lu", (unsigned long)self.currentIndex);
        
        MFCategory *tempCategory = self.categoryArray[self.currentIndex];
        
        NSLog(@"%@", tempCategory.name);
        
        [self showInterestsAtIndex:self.currentIndex];
 
    } else {
        
        self.categorySelectedHighlight.hidden = YES;

    }

}

- (void) checkUserInterests

{
    NSLog(@"%@", self.currentUser);
}

- (void) showInterestsAtIndex:(NSUInteger)index

{

    NSUInteger startXvalueScrollView = 0;
    NSUInteger interestPadding = 5;

    [[self.interestScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    MFCategory *tempCategory = self.categoryArray[index];

    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [self.categoryArray count] * (100 + interestPadding), 150)];

    self.interestsArray = [tempCategory.interests allObjects];
    
    for (NSUInteger i = 0; i < [self.interestsArray count]; i++) {
        
        UIView *interestContainerView = [[UIView alloc]initWithFrame:CGRectMake(startXvalueScrollView, 0, 100, 150)];
        UIImageView *interestImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];

        MFInterest *tempInterest = self.interestsArray[i];

        interestImageView.layer.cornerRadius = interestImageView.frame.size.height/2;
        interestImageView.clipsToBounds = YES;

        UIImage *image = [self getImageWithName:tempInterest.name];
        
        [interestImageView setImage:image];
        
        [interestContainerView addSubview:interestImageView];

        BOOL interestShouldBeSelected = NO;
        
        id interestIndex = [self.interestKeys objectForKey:tempInterest.name];

        // Comment out the below for loop and set selectedImageView.hidden = YES if any problems
        
        for (id userInterestIndex in self.userInterests) {
            
            if ([interestIndex isEqual:userInterestIndex]) {
                
                NSLog(@"Match %@ %@", interestIndex, userInterestIndex);

                interestShouldBeSelected = YES;

            }
        }
        
        UIImageView *selectedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        [selectedImageView setImage:[UIImage imageNamed:@"checkmark_2x"]];
        selectedImageView.accessibilityLabel = @"Interest Highlight";
        selectedImageView.layer.cornerRadius = selectedImageView.frame.size.height/2;
        selectedImageView.clipsToBounds = YES;
        
        if (interestShouldBeSelected) {
            selectedImageView.hidden = NO;
        } else {
            selectedImageView.hidden = YES;
        }
        
        [interestContainerView addSubview:selectedImageView];

        interestContainerView.accessibilityLabel = tempInterest.name;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleInterestTap:)];
        
        [interestContainerView addGestureRecognizer:tapRecognizer];
        
        [contentView addSubview:interestContainerView];

        UILabel *interestLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, interestContainerView.frame.size.width, 20)];
        interestLabel.text = tempInterest.name;
        interestLabel.font = [UIFont boldSystemFontOfSize:10];
        interestLabel.textColor = MFtealColor;
        interestLabel.textAlignment = NSTextAlignmentCenter;
        [interestContainerView addSubview:interestLabel];

        startXvalueScrollView += 100 + interestPadding;

    }

    contentView.frame = CGRectMake(0, 0, [self.interestsArray count] * (100 + interestPadding), 150);
    
    self.interestScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 230, 320, 150)];
    self.interestScrollView.accessibilityLabel = tempCategory.name;
    self.interestScrollView.scrollEnabled = YES;
    self.interestScrollView.showsHorizontalScrollIndicator = NO;
    self.interestScrollView.contentSize = CGSizeMake([self.interestsArray count] * (100 + interestPadding), 150);
    
    [self.interestScrollView addSubview:contentView];
    [self.containerView addSubview:self.interestScrollView];
    
}



- (void)categorySelected

{
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
}



- (void)handleInterestTap:(UITapGestureRecognizer *)recognizer

{
    NSMutableArray *addInterest = [[NSMutableArray alloc]init];
    NSMutableString *stringWithId = [[NSMutableString alloc]init];
    NSString *interestTapped = recognizer.view.accessibilityLabel;

    NSLog(@"%@", recognizer.view);

    self.categorySelectedHighlight.hidden = NO;

    for (UIView *selectedView in recognizer.view.subviews) {
        
        if ([selectedView.accessibilityLabel isEqualToString:@"Interest Highlight"] ) {
            
            if (selectedView.hidden == YES) {
                
                selectedView.hidden = NO;
                
            } else {
                
                selectedView.hidden = YES;
            }
        }
    }

    [MFAPIClient getUserInterestsWithCompletion:^(NSArray *array) {

        for (NSDictionary *dictionary in array) {
            
            [addInterest addObject:dictionary[@"id"]];
            
        }
        
        NSLog(@"%@", array);

        id interestIdToAdd = [self.interestKeys objectForKey:interestTapped];

        [addInterest addObject:interestIdToAdd];

        for (NSUInteger i = 0; i < [addInterest count]; i++) {

            if (i == ([addInterest count] - 1)) {
                
                NSString *tempString = [NSString stringWithFormat:@"%@", addInterest[i]];
                
                [stringWithId appendString:tempString];
                
            } else {
                
                NSString *tempString = [NSString stringWithFormat:@"%@,", addInterest[i]];
                
                [stringWithId appendString:tempString];
            }
        }
        
        NSLog(@"addInterest %@", addInterest);
        
        [MFAPIClient createUserInterest:stringWithId completion:^{
            
            NSLog(@"Posted");
            
        }];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end