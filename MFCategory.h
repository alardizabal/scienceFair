//
//  MFCategory.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/5/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MFInterest;

@interface MFCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSSet *interests;
@end

@interface MFCategory (CoreDataGeneratedAccessors)

- (void)addInterestsObject:(MFInterest *)value;
- (void)removeInterestsObject:(MFInterest *)value;
- (void)addInterests:(NSSet *)values;
- (void)removeInterests:(NSSet *)values;

+(instancetype)categoryWithContext: (NSManagedObjectContext *)context;

@end
