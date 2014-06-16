//
//  appSetting.m
//  footballData
//
//  Created by EGS on 14-5-7.
//  Copyright (c) 2014年 www.kantai.co. All rights reserved.
//

#import "appSetting.h"
#import "apiCache_plistVer.h"

@implementation appSetting

+ (appSetting *)shareSetting
{
    static appSetting *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[appSetting alloc]  init];
        
        //===111 img base urlmake init
        _sharedClient.useDemo_Url = YES;//默认使用 demo url
        
    });
    
    
    
    
    return _sharedClient;
}
-(void)sycn_baseURL_img
{
    //===111 img base urlmake sycn netStatus
    [HTTP_VERB_verCheck sycn_baseURL_imgType:^(BOOL isDemoStatus) {

#warning egs  可以手动切换  baseUrl 类型  NO;//
        InnerLog(@"isDemoStatus %d",isDemoStatus);
        
#ifdef DEBUG
        self.useDemo_Url = NO;//YES;//debug 下都用真实url
#else
        self.useDemo_Url = isDemoStatus;//
#endif
        
        
        [[NSNotificationCenter  defaultCenter] postNotificationName:kNotice4ImgUrlType
                                                             object:nil];
    }];
}


- (BOOL)isFavorited:(uint)teamID
{
    NSArray *arrTeamFavorid = API_PLIST_GETarr(kTeamLocalFavoritesList);
    
    for (NSDictionary *dic in arrTeamFavorid) {
        int teamIDX = [[dic objectForKeyOrNil:@"teamid"] targetIntValue];
        
        if (teamIDX==teamID) {
            return  YES;
        }
    }
    
    return NO;
}

-(BOOL)saveTeamObj:(teamObj *)teamO
{
    NSArray *arrTeamFavorid = API_PLIST_GETarr(kTeamLocalFavoritesList);
    
    BOOL isExist = NO;
    for (NSDictionary *dic in arrTeamFavorid) {
        int teamIDX = [[dic objectForKeyOrNil:@"teamid"] targetIntValue];
        
        if (teamIDX == [teamO.team_id targetIntValue]) {
            isExist =YES;
            
            return NO;//yijing cunzai
        }
    }
    
    if (isExist==NO) {
        if (arrTeamFavorid!=nil
            &&[arrTeamFavorid count]>0) {
            
            NSMutableArray *mArrNew = [NSMutableArray arrayWithArray:arrTeamFavorid];
            [mArrNew addObject:@{@"teamid": teamO.team_id,@"type":teamO.type, @"teamname":teamO.club_name,@"teamlogo":teamO.logourl!=nil?teamO.logourl:@"default.png"}];
            
            API_PLIST_Set(mArrNew, kTeamLocalFavoritesList);
        }
        else
        {
            NSMutableArray *mArrNew = [NSMutableArray new];
            [mArrNew addObject:@{@"teamid": teamO.team_id,@"type":teamO.type,@"teamname":teamO.club_name,@"teamlogo":teamO.logourl!=nil?teamO.logourl:@"default.png"}];
            
            API_PLIST_Set(mArrNew, kTeamLocalFavoritesList);
        }
        
        
        return YES;
    }

    return NO;
}

-(BOOL)removeTeamObj:(teamObj *)teamO
{
    NSArray *arrTeamFavorid = API_PLIST_GETarr(kTeamLocalFavoritesList);
    
    NSMutableArray *mArrNew = [NSMutableArray arrayWithArray:arrTeamFavorid];
    
    BOOL isExist = NO;
    for (NSDictionary *dic in arrTeamFavorid) {
        int teamIDX = [[dic objectForKeyOrNil:@"teamid"] targetIntValue];
        
        if (teamIDX == [teamO.team_id targetIntValue]) {
            isExist =YES;
            
            [mArrNew removeObject:dic];
        }
    }
    
    if (isExist) {
        
        API_PLIST_Set(mArrNew, kTeamLocalFavoritesList);
        return YES;//remove succ
    }
    else
    {
        return NO;
    }
    
    return NO;
}


//===自定判断，字段获取teamUrl
-(NSURL *)actionAutoMake_teamLogoURL:(NSString *)teamLogoStr
{
    

    if (_useDemo_Url) {
        //demo url
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FakeTeamUrlStr,teamLogoStr]];
    }
    else
    {
        //real url
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RealTeamUrlStr,teamLogoStr]];
    }
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FakeTeamUrlStr,teamLogoStr]];
}

-(NSURL *)actionAutoMake_leagueLogoURL:(NSString *)leagueLogoStr{
    if (_useDemo_Url) {
        //demo url
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FakeCompetitionUrlStr,leagueLogoStr]];
    }
    else
    {
        //real url
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RealCompetitionUrlStr,leagueLogoStr]];
    }
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FakeCompetitionUrlStr,leagueLogoStr]];
}

-(NSURL *)actionAutoMake_road2ChampionURL{
    if (_useDemo_Url) {
        //demo url
        return [NSURL URLWithString:FakeRoad2ChampionUrlStr];
    }
    else
    {
        //real url
        return [NSURL URLWithString:RealRoad2ChampionUrlStr];
    }
    
    return [NSURL URLWithString:FakeRoad2ChampionUrlStr];

}

-(NSURL *)actionAutoMake_nationBgURL{
    if (_useDemo_Url) {
        //demo url
        return [NSURL URLWithString:FakeNationBgUrlStr];
    }
    else
    {
        //real url
        return [NSURL URLWithString:RealNationBgUrlStr];
    }
    
    return [NSURL URLWithString:FakeNationBgUrlStr];
}

@end
