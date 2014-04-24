//
//  wjClient.m
//  egsFramework
//
//  Created by EGS on 14-4-24.
//  Copyright (c) 2014年 EGS. All rights reserved.
//

#import "wjClient.h"

#define kParse_APIVer1  @"https://api.parse.com"

@implementation wjClient

+(wjClient *)shareClient
{
    static wjClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[wjClient alloc]  initWithBaseURL:[NSURL URLWithString:kParse_APIVer1]];
        [_sharedClient initCustom];
    });
    
    return _sharedClient;
}


- (void)initCustom
{
    
    if (self) {
        //custom init method & var
        
        DebugLog(@"set %@",self.requestSerializer.HTTPRequestHeaders);
        
        //===anthur right
        [self.requestSerializer setValue:@"CAo6GTCJ1RH1lwT3mB9X5bG5pvCtSfJMGqHn5az6"
                      forHTTPHeaderField:@"X-Parse-Application-Id"];
        [self.requestSerializer setValue:@"BFXGgzLhJOEwk1iq1BhA3TRQgb3bw1pSwNOqRqwt"
                      forHTTPHeaderField:@"X-Parse-REST-API-Key"];
        [self.requestSerializer setValue:@"application/json"
                      forHTTPHeaderField:@"Content-Type"];
    }
}

@end
