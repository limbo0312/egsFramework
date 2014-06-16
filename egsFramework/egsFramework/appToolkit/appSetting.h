//
//  appSetting.h
//  footballData
//
//  Created by EGS on 14-5-7.
//  Copyright (c) 2014年 www.kantai.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dataObjMap.h"


/**
 *  用在诸如，设置页面那里。。。
 *todoExample： 归档所有" [NSUserDefaults standardUserDefaults] "  之结构碎片
 */

/********************************
 ==========appMacroKey========
 ********************************/

/**
 *  存放arr，arr内元素为dic_2key  @{@"teamid":660,@"teamname":阿森纳}
 */
#define kTeamLocalFavoritesList  @"keyTeamLocalFavorites" //本地收藏的球队。& syc2jpush

/**
 *  .........
 */
#define kMatchLocalTrackList   @"keyMatchLocalTrack"  //关注的重要比赛。   & jpush


#define AutoMake_teamLogoURL(teamlogoStr)  [[appSetting shareSetting] actionAutoMake_teamLogoURL:teamlogoStr] //convinence MEthod make

#define AutoMake_leagueLogoURL(leaguelogoStr)  [[appSetting shareSetting] actionAutoMake_leagueLogoURL:leaguelogoStr] //convinence MEthod make

#define actionAutoMake_road2Champion [[appSetting shareSetting] actionAutoMake_road2ChampionURL] //convinence MEthod make

#define actionAutoMake_nationBg  [[appSetting shareSetting] actionAutoMake_nationBgURL] //convinence MEthod make

#define kNotice4ImgUrlType @"Notice4ImgUrlType"

@interface appSetting : NSObject


@property (nonatomic,assign) BOOL useDemo_Url;//yes ==>demo url   no==> real url   关键环境参数




+ (appSetting *)shareSetting;
-(void)sycn_baseURL_img;

//===判断是否
- (BOOL)isFavorited:(uint)teamID;

-(BOOL)saveTeamObj:(teamObj *)teamO;

-(BOOL)removeTeamObj:(teamObj *)teamO;

//===自定判断，字段获取teamUrl
-(NSURL *)actionAutoMake_teamLogoURL:(NSString *)teamLogoStr;

-(NSURL *)actionAutoMake_leagueLogoURL:(NSString *)leagueLogoStr;

-(NSURL *)actionAutoMake_road2ChampionURL;

-(NSURL *)actionAutoMake_nationBgURL;

@end
