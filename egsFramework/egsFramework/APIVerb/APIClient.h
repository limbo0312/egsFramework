//
//  APIClient.h
//  egsFramework
//
//  Created by EGS on 14-4-22.
//  Copyright (c) 2014年 EGS. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface APIClient :AFHTTPRequestOperationManager


+(APIClient *)shareClient;


@end
