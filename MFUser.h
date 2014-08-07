//
//  MFUser.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/6/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MFComment, MFFind, MFInterest, MFMake, MFUser;

@interface MFUser : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * profileImageURL;
@property (nonatomic, retain) NSString * headerImageURL;
@property (nonatomic, retain) NSSet *makes;
@property (nonatomic, retain) NSSet *finds;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSSet *followers;
@property (nonatomic, retain) NSSet *following;
@property (nonatomic, retain) NSSet *interests;
@end

@interface MFUser (CoreDataGeneratedAccessors)

+(instancetype)userWithContext: (NSManagedObjectContext *)context;
+(MFUser *)currentUser;


- (void)addMakesObject:(MFMake *)value;
- (void)removeMakesObject:(MFMake *)value;
- (void)addMakes:(NSSet *)values;
- (void)removeMakes:(NSSet *)values;

- (void)addFindsObject:(MFFind *)value;
- (void)removeFindsObject:(MFFind *)value;
- (void)addFinds:(NSSet *)values;
- (void)removeFinds:(NSSet *)values;

- (void)addCommentsObject:(MFComment *)value;
- (void)removeCommentsObject:(MFComment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addFollowersObject:(MFUser *)value;
- (void)removeFollowersObject:(MFUser *)value;
- (void)addFollowers:(NSSet *)values;
- (void)removeFollowers:(NSSet *)values;

- (void)addFollowingObject:(MFUser *)value;
- (void)removeFollowingObject:(MFUser *)value;
- (void)addFollowing:(NSSet *)values;
- (void)removeFollowing:(NSSet *)values;

- (void)addInterestsObject:(MFInterest *)value;
- (void)removeInterestsObject:(MFInterest *)value;
- (void)addInterests:(NSSet *)values;
- (void)removeInterests:(NSSet *)values;

@end
