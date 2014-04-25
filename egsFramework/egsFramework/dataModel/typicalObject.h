//
//  typicalObject.h
//  egsFramework
//
//  Created by EGS on 14-4-25.
//  Copyright (c) 2014年 EGS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    GHIssueStateOpen,
    GHIssueStateClosed
} GHIssueState;

@interface typicalObject : NSObject <NSCoding, NSCopying>


@property (nonatomic, copy, readonly) NSURL *URL;
@property (nonatomic, copy, readonly) NSURL *HTMLURL;
@property (nonatomic, copy, readonly) NSNumber *number;
@property (nonatomic, assign, readonly) GHIssueState state;
@property (nonatomic, copy, readonly) NSString *reporterLogin;
@property (nonatomic, copy, readonly) NSDate *updatedAt;
//@property (nonatomic, strong, readonly) GHUser *assignee;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;


- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
 