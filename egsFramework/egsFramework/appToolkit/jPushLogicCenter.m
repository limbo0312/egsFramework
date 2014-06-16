//
//  jPushLogicCenter.m
//  saidian
//
//  Created by EGS on 14-4-11.
//  Copyright (c) 2014年 althrun.zala. All rights reserved.
//

#import "jPushLogicCenter.h"

#import "NSString+Extensions.h"
#import "NSDate-Utilities.h"
#import "apiCache_plistVer.h"

#define KLocal_FavorTeamIDArr @"Local_FavorTeamIDArr"
#define KLocal_FavorMatchIDArr @"Local_FavorMatchIDArr"



@implementation jPushLogicCenter

+ (jPushLogicCenter *)shareUserLogicCenter
{
    static jPushLogicCenter *_shareCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareCenter = [[jPushLogicCenter alloc] init];
    });
    
    return _shareCenter;
}


-(void)syncTag_onTeams:(NSString *)teamIDs
{
    //1===>format recognize
    if (![teamIDs isKindOfClass:[NSString class]]) {
        DebugLog(@"EGS:格式错误，检查此处");
        
        return;
    }
    
    
    //2==>
    NSArray *arrTeams = [teamIDs componentsSeparatedByString:@","];
    
    NSSet *tSet = [NSSet setWithArray:arrTeams];
    
    NSSet *mSet = [self getMatchSet];
    
    [self syncTag_mergeWay:mSet
                          :tSet];
    
}

-(void)syncTag_onMatchs:(NSDictionary *)matchDic
                       :(BOOL)isFavor
{
    //1===>format recognize
        BOOL key1 = [self isDicExist:matchDic :kMatch_ID];
        BOOL key2 = [self isDicExist:matchDic :kmDate];
        
        if (!key1||!key2) {
            DebugLog(@"EGS:one of key missing");
            return;
        }
    
    
    //2==>
    [self mergeMatchArr:matchDic :isFavor];//updateOnLocal
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)); // 1
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){ // 2
        NSSet *tSet = [self getTeamSet];
        
        NSSet *mSet = [self getMatchSet];
        
        [self syncTag_mergeWay:mSet
                              :tSet];
    });
    


    


}


-(void)syncTag_mergeWay:(NSSet *)mSet
                       :(NSSet *)tSet
{
    NSMutableSet *allSet = [NSMutableSet setWithSet:mSet];
    
    for (id objSet in tSet) {
        [allSet addObject:objSet];
    }

    
    [APService setTags:allSet
                 alias:@"alex" //忽略alias
      callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                object:self];
    
}

//==helper method
-(void)synTag_clearClose
{
    [APService setTags:[NSSet new]
                 alias:@"alex" //忽略alias
      callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                object:self];
}
-(void)synTag_startOpen
{
    NSSet *tSet = [self getTeamSet];
    NSSet *mSet = [self getMatchSet];
    [self syncTag_mergeWay:mSet
                          :tSet];
    

}

#pragma mark -- callBack by jPush

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    DebugLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

#pragma mark -- private helper method
-(void)mergeMatchArr:(NSDictionary *)objDic
                    :(BOOL)isFavor
{
    NSString *new_mID = [objDic objectForKey:kMatch_ID];
    
    NSMutableArray *beforeValid = [self getMatchArr_WithFilter];
    
    if (isFavor) {
        BOOL isHave = NO ;
        
        for (NSDictionary *dic  in beforeValid) {
            NSString *mID = [dic objectForKey:kMatch_ID];
            
            if ([mID isEqualToString:new_mID]) {
                isHave = YES;
            }
        }
        
        if (!isHave) {
            [beforeValid addObject:objDic];
            
//            NSUserDefaults *userPlist = [NSUserDefaults standardUserDefaults];
//            [userPlist setObject:beforeValid
//                          forKey:KLocal_FavorMatchIDArr];
//            [userPlist synchronize];
            
            API_PLIST_Set(beforeValid, KLocal_FavorMatchIDArr);
        }
        else
        {
            DebugLog(@"EGS:already exist");
        }
    }
    else
    {
        //===>反收藏
        NSInteger removeInt = -42;
        
        for (int i=0; i< [beforeValid count]; i++) {
            NSDictionary *dic = [beforeValid objectAtIndexSavely:i];
            NSString *mID = [dic objectForKey:kMatch_ID];
            
            if ([mID isEqualToString:new_mID]) {
                removeInt = i;
            }
        }
        
        //===确认存在需要被移除obj
        if (removeInt!=-42) {
            
            [beforeValid  removeObjectAtIndex:removeInt];
            
            if ([beforeValid count]==0) {
                
                API_PLIST_Remove(KLocal_FavorMatchIDArr);
            }
            else
                API_PLIST_Set(beforeValid, KLocal_FavorMatchIDArr);
            
        }
        
    }
    
    

}

-(NSMutableArray *)getMatchArr_WithFilter
{
//    NSUserDefaults *userPlist = [NSUserDefaults standardUserDefaults];
    
    NSArray *matchFavorArr = API_PLIST_GETarr(KLocal_FavorMatchIDArr);//[userPlist arrayForKey:KLocal_FavorMatchIDArr];
    
    NSMutableArray *matchFavorArr_filtered = [NSMutableArray new];
    
    for (NSDictionary *dic in matchFavorArr) {
        DebugLog(@"%@",dic);
        NSString *dateM = [dic objectForKey:kmDate];
        NSDate *datePlus8 = [NSString  getDateByString:dateM
                                                Format:@"yyyyMMddHHmmss"];
        
        
        if ([datePlus8 isEarlierThanDate:[NSDate dateWithDaysBeforeNow:2]]) {
            //前天的match 移除
            continue;
        }
        [matchFavorArr_filtered addObject:dic];
    }
    
    return matchFavorArr_filtered;
}

-(NSSet *)getMatchSet
{
    NSMutableArray *beforeValid = [self getMatchArr_WithFilter];

    NSMutableArray *mArr = [NSMutableArray new];
    
    for (NSDictionary *dic in beforeValid) {
        
        [mArr addObject:[dic objectForKey:kMatch_ID]];
    }
    
    NSSet *setMatch = [NSSet setWithArray:mArr];
    
    return setMatch;
}


-(NSSet *)getTeamSet
{
//    NSUserDefaults *userPlist = [NSUserDefaults standardUserDefaults];
    
    NSString *teams = API_PLIST_GETstr(KAPP_MYTEAMS_KEY); //[userPlist objectForKey:KAPP_MYTEAMS_KEY];
    
    NSMutableSet *mSet = [NSMutableSet new];
    
    for (NSString *idStr in [teams componentsSeparatedByString:@","]) {
        
        NSMutableString *strM = [NSMutableString stringWithString:idStr];
        
        [strM insertString:@"t" atIndex:0];
        
        [mSet addObject:strM];
    }
    
    return mSet;
}

#pragma mark -- otherClassHelper
-(BOOL)isDicExist:(NSDictionary *)dic
                 :(id)key
{
    for (NSString *strKey in [dic allKeys]) {
        
        if ([key isKindOfClass:[NSString class]]
            &&[strKey isEqualToString:key]) {
            return YES;
        }
        
    }
    return NO;
}



@end
