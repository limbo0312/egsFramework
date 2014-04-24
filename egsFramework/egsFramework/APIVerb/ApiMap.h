//
//  ApiMap.h
//  egsFramework
//
//  Created by EGS on 14-4-22.
//  Copyright (c) 2014年 EGS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define kGlobalBaseURL   @"http://api.bitcoincharts.com"

#import "APIClient.h"// main client
#import "wjClient.h" // parse client

//=========group01 API  about bitCoin
#define kBitCoinMarket   @"/v1/markets.json"   //list of bitCoinMarket Price



//=========group02 API  about parse
#define shareHeaderDic @{@"X-Parse-Application-Id":@"CAo6GTCJ1RH1lwT3mB9X5bG5pvCtSfJMGqHn5az6",\
                        @"X-Parse-REST-API-Key":@"BFXGgzLhJOEwk1iq1BhA3TRQgb3bw1pSwNOqRqwt"}

#define kWJ_words @"1/classes/folou_wuji"


//=========group03 API




//=========group04 API




//=========group05 API