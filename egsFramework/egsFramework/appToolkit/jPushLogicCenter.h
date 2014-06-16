//
//  jPushLogicCenter.h
//  saidian
//
//  Created by EGS on 14-4-11.
//  Copyright (c) 2014年 althrun.zala. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APService.h"

#define kMatch_ID @"matchID"
#define kmDate    @"mDate"  //@"yyyyMMddHHmmss"
#define KAPP_MYTEAMS_KEY    @"app_myteams_key"

@interface jPushLogicCenter : NSObject

+ (jPushLogicCenter *)shareUserLogicCenter;


//==main method
-(void)syncTag_onTeams:(NSString *)teamIDs;

-(void)syncTag_onMatchs:(NSDictionary *)matchDic
                       :(BOOL)isFavor;

-(NSMutableArray *)getMatchArr_WithFilter;

-(void)synTag_clearClose;
-(void)synTag_startOpen;

@end
