//
//  MFBackground.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/5/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFBackground.h"
#import "MFDataStore.h"
#import "MFCategory.h"
//#import "AALAPIClient.h"
#import "MFAPIClient.h"

@implementation MFBackground





+(void)LoadCategoryAndInterestImagesInBackGround
{
    MFDataStore *store = [MFDataStore sharedStore];
    [MFAPIClient getCategoryImagesWithCompletion:^(NSDictionary *dictionary) {
        for (NSDictionary *eachCategory in dictionary)
        {
            MFCategory *category = [store createCategory];
            category.name = eachCategory[@"name"];
            category.imageURL = [self getNameOfImageURLWithName:category.name];
            
            NSArray *interestsDictionary = eachCategory[@"categories"];
            for (NSUInteger i = 0; i < [interestsDictionary count]; i++) {
                MFInterest *interest = [store createInterest];
                interest.name = interestsDictionary[i][@"name"];
                interest.imageURL = [self getNameOfImageURLWithName:interest.name];
                interest.category = category;
                
            }
        }
    }];
    
    NSOperationQueue *imageFetchingQueue = [[NSOperationQueue alloc] init];
    [imageFetchingQueue addOperationWithBlock:^{
        
        [MFAPIClient getCategoryImagesWithCompletion:^(NSDictionary *dictionary) {
            for (NSDictionary *eachCategory in dictionary) {
                
                NSString *name = eachCategory[@"name"];
                NSString *tempImageURLString = eachCategory[@"images"][@"retina"];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tempImageURLString]]];
                [self saveImage:image WithName:name];
                
                NSArray *interestsDictionary = eachCategory[@"categories"];
                
                for (NSUInteger i = 0; i < [interestsDictionary count]; i++) {
                    
                    NSString *interestName = interestsDictionary[i][@"name"];
                    NSString *tempImageURLString = interestsDictionary[i][@"images"][@"retina"];
                    
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tempImageURLString]]];
                    [self saveImage:image WithName:interestName];
                
                }
            }
        }];
    }];
}

+(void)saveImage: (UIImage*)image WithName:(NSString *)name
{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fixedString = [name stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithFormat: @"%@",fixedString]];
    NSData* data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
}

+(NSString *)getNameOfImageURLWithName: (NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fixedString = [name stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithFormat: @"%@",fixedString]];
    return path;
}


@end
