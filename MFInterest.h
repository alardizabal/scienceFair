//
//  MFInterest.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/6/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MFCategory, MFUser;

@interface MFInterest : NSManagedObject

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) MFCategory *category;
@property (nonatomic, retain) NSSet *users;
@end

@interface MFInterest (CoreDataGeneratedAccessors)

+(instancetype)interestWithContext: (NSManagedObjectContext *)context;

- (void)addUsersObject:(MFUser *)value;
- (void)removeUsersObject:(MFUser *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
