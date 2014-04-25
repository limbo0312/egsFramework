//
//  typicalObject.m
//  egsFramework
//
//  Created by EGS on 14-4-25.
//  Copyright (c) 2014年 EGS. All rights reserved.
//

#import "typicalObject.h"

@implementation typicalObject



+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    _URL = [NSURL URLWithString:dictionary[@"url"]];
    _HTMLURL = [NSURL URLWithString:dictionary[@"html_url"]];
    _number = dictionary[@"number"];
    
    if ([dictionary[@"state"] isEqualToString:@"open"]) {
        _state = GHIssueStateOpen;
    } else if ([dictionary[@"state"] isEqualToString:@"closed"]) {
        _state = GHIssueStateClosed;
    }
    
    _title = [dictionary[@"title"] copy];
    _body = [dictionary[@"body"] copy];
    _reporterLogin = [dictionary[@"user"][@"login"] copy];
//    _assignee = [[GHUser alloc] initWithDictionary:dictionary[@"assignee"]];
    
    _updatedAt = [self.class.dateFormatter dateFromString:dictionary[@"updated_at"]];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self == nil) return nil;
    
    _URL = [coder decodeObjectForKey:@"URL"];
    _HTMLURL = [coder decodeObjectForKey:@"HTMLURL"];
    _number = [coder decodeObjectForKey:@"number"];
//    _state = [coder decodeUnsignedIntegerForKey:@"state"];
    _title = [coder decodeObjectForKey:@"title"];
    _body = [coder decodeObjectForKey:@"body"];
    _reporterLogin = [coder decodeObjectForKey:@"reporterLogin"];
//    _assignee = [coder decodeObjectForKey:@"assignee"];
    _updatedAt = [coder decodeObjectForKey:@"updatedAt"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.URL != nil) [coder encodeObject:self.URL forKey:@"URL"];
    if (self.HTMLURL != nil) [coder encodeObject:self.HTMLURL forKey:@"HTMLURL"];
    if (self.number != nil) [coder encodeObject:self.number forKey:@"number"];
    if (self.title != nil) [coder encodeObject:self.title forKey:@"title"];
    if (self.body != nil) [coder encodeObject:self.body forKey:@"body"];
    if (self.reporterLogin != nil) [coder encodeObject:self.reporterLogin forKey:@"reporterLogin"];
//    if (self.assignee != nil) [coder encodeObject:self.assignee forKey:@"assignee"];
    if (self.updatedAt != nil) [coder encodeObject:self.updatedAt forKey:@"updatedAt"];
    
//    [coder encodeUnsignedInteger:self.state forKey:@"state"];
}

- (id)copyWithZone:(NSZone *)zone {
    typicalObject *typicalO = [[self.class allocWithZone:zone] init];
    typicalO->_URL = self.URL;
    typicalO->_HTMLURL = self.HTMLURL;
    typicalO->_number = self.number;
    typicalO->_state = self.state;
    typicalO->_reporterLogin = self.reporterLogin;
//    issue->_assignee = self.assignee;
    typicalO->_updatedAt = self.updatedAt;
    
    typicalO.title = self.title;
    typicalO.body = self.body;
    
    return typicalO;
}

- (NSUInteger)hash {
    return self.number.hash;
}

- (BOOL)isEqual:(typicalObject *)typiObj {
    if (![typiObj isKindOfClass:typicalObject.class]) return NO;
    
    return [self.number isEqual:typiObj.number] && [self.title isEqual:typiObj.title] && [self.body isEqual:typiObj.body];
}



@end

