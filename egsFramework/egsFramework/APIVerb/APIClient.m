//
//  APIClient.m
//  egsFramework
//
//  Created by EGS on 14-4-22.
//  Copyright (c) 2014年 EGS. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

+(APIClient *)shareClient
{
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc]  initWithBaseURL:[NSURL URLWithString:kGlobalBaseURL]];
        [_sharedClient initCustom];
    });
    
    return _sharedClient;
}


- (void)initCustom
{

    if (self) {
        //custom init method & var
        
        DebugLog(@"set %@",self.responseSerializer.acceptableContentTypes)
        
        //==buyfor 愚蠢程序猿！！！===> 基本的http协议都不遵从，甚至不明白！！！
        
        NSMutableSet *mSet = [NSMutableSet setWithArray:[self.responseSerializer.acceptableContentTypes allObjects]];
        [mSet addObject:@"text/html"];
        self.responseSerializer.acceptableContentTypes = mSet;
    }
}

@end
