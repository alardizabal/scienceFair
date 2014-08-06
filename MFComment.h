//
//  MFComment.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/6/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MFUser;

@interface MFComment : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) MFUser *user;

@end
