//
//  wjClient.h
//  egsFramework
//
//  Created by EGS on 14-4-24.
//  Copyright (c) 2014年 EGS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPRequestOperationManager.h"

@interface wjClient : AFHTTPRequestOperationManager

+(wjClient *)shareClient;

@end
