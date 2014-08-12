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
                interest.uniqueID = interestsDictionary[i][@"id"];
                interest.imageURL = [self getNameOfImageURLWithName:[NSString stringWithFormat:@"interest%@",interest.uniqueID]];
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
//                NSLog(@"Saved a category");
                NSArray *interestsDictionary = eachCategory[@"categories"];
                
                for (NSUInteger i = 0; i < [interestsDictionary count]; i++) {
                    
                    NSNumber *interestIDNumber = interestsDictionary[i][@"id"];
                    NSString *interestID = [NSString stringWithFormat:@"interest%@",interestIDNumber];
                    NSString *tempImageURLString = interestsDictionary[i][@"images"][@"retina"];
                    
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tempImageURLString]]];
                    [self saveImage:image WithName:interestID];
//                    NSLog(@"Saved an Interest");
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

+(UIImage *)getImageWithUniqueIdentifier:(NSString *)identifier
{
    NSData *pngData = [NSData dataWithContentsOfFile:identifier];
    UIImage *image = [UIImage imageWithData:pngData];
    return image;
}

@end
