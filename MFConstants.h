//
//  MFConstants.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/1/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MFnavBarColor [UIColor colorWithRed:45/255.0 green:62/255.0 blue:81/255.0 alpha:1]
#define MFtealColor [UIColor colorWithRed:0 green:119.0/255.0 blue:126.0/255.0 alpha:1.0]
#define MFdarkTealColor [UIColor colorWithRed:0 green:80/255.0 blue:86/255.0 alpha:1.0]
#define MFmenuFont [UIFont fontWithName:@"NeutraText-BookSC" size:22.0f]
#define MFhelvetica [UIFont fontWithName:@"HelveticaNeue-Bold" size:16]
#define MFhelveticaNotifications [UIFont fontWithName:@"HelveticaNeue" size:16]
#define MFhelveticaUploadScreen [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]

@interface MFConstants : NSObject

extern NSString *const kUSER_CREATE_URL;
extern NSString *const kUSER_LOGIN_URL;
extern NSString *const kCATEGORY_API_URL;
extern NSString *const kFEED_API_URL;
extern NSString *const kUSER_PROFILE_API_URL;
extern NSString *const kCREATE_UPDATE_INTERESTS_URL;

@end
