//
//  MFDataStore.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/1/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "MFUser.h"
#import "MFCategory.h"
#import "MFInterest.h"
#import "MFMake.h"

@interface MFDataStore : NSObject
@property (strong, nonatomic, readonly) NSManagedObjectContext *context;
+ (instancetype)sharedStore;
-(MFUser *) createUser;
-(MFCategory *)createCategory;
-(MFInterest *)createInterest;
-(MFMake *)createMake;

@end
