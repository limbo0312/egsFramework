//
//  mtlObject.m
//  egsFramework
//
//  Created by EGS on 14-4-25.
//  Copyright (c) 2014年 EGS. All rights reserved.
//

#import "Mantle.h"

#import "mtlObject.h"

@implementation mtlObject

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"URL": @"url",
             @"HTMLURL": @"html_url",
             @"reporterLogin": @"user.login",
             @"assignee": @"assignee",
             @"updatedAt": @"updated_at"
             };
}

+ (NSValueTransformer *)URLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)stateJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"open": @(GHIssueStateOpen),
                                                                           @"closed": @(GHIssueStateClosed)
                                                                           }];
}

+ (NSValueTransformer *)assigneeJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:mtlObject.class];
}

+ (NSValueTransformer *)updatedAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}


@end
