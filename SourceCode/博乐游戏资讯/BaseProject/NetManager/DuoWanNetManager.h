//
//  DuoWanNetManager.h
//  BaseProject
//
//  Created by drouce on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "DuoWanModel.h"

typedef NS_ENUM(NSUInteger,HeroType) {
    
    HeroTypeFree,               //免费英雄
    HeroTypeAll,                //全部英雄
};

@interface DuoWanNetManager : BaseNetManager

/**
 *  英雄类型
 *
 *  @param type 英雄类型
 *
 *  @return 当前请求所在认为
 */
+ (id)getHeroWithType:(HeroType)heroType kCompletionHandle;

/**
 *  获取英雄皮肤
 *
 *  @param heroName 英雄的名字
 *
 *  @return 网络请求任务
 */
+ (id)getHeroSkinsWithHeroName:(NSString *)heroName kCompletionHandle;
/**
 *  获取英雄配音
 *
 *  @param heroName 英雄名字
 *
 *  @return 网络请求任务
 */
+ (id)getHeroSoundWithHeroName:(NSString *)heroName kCompletionHandle;
/**
 *  获取英雄视频
 *
 *  @param page     视频页数，从1开始
 *  @param heroNmae 英雄的名字作为关键字
 *
 *  @return 网络请求任务
 */
+ (id)getHeroVideoPage:(NSInteger)page tag:(NSString *)heroNmae kCompletionHandle;
/**
 *  获取英雄出装
 *
 *  @param heroName 英雄的名字
 *
 *  @return 网络请求任务
 */
+ (id)getHeroCZWithHeroName:(NSString *)heroName kCompletionHandle;
/**
 *  获取英雄资料
 *
 *  @param heroName 英雄名字
 *
 *  @return 网络请求任务
 */
+ (id)getHeroDetailWithHeroName:(NSString *)heroName kCompletionHandle;
/**
 *
 *  获取天赋符文
 *  @param heroName 英雄名字
 *
 *  @return 网络请求任务
 */
+ (id)getHeroGiftWithHeroName:(NSString *)heroName kCompletionHandle;
/**
 *  获取英雄改动
 *
 *  @param heroName 英雄名字
 *
 *  @return 网络请求任务
 */
+ (id)getHeroChangeWithHeroName:(NSString *)heroName kCompletionHandle;
/**
 *  获取一周数据
 *
 *  @param heroId 英雄ID
 *
 *  @return 网络请求任务
 */
+ (id)getHeroWeekDataWithId:(NSInteger)heroId kCompletionHandle;

//---------------------------------------------------------------------------------
//游戏百科

/**
 *  获取游戏百科列表
 */
+ (id)getToolMenuWithCompletionHandle:(void(^)(id model,NSError *error))completionHandle;
/**
 *  获取装备分类
 */
+ (id)getZBCategoryWithCompletionHandle:(void(^)(id model, NSError *error))completionHandle;
/**
 *  获取某分类装备列表
 *
 *  @param tag 分类tag
 *
 *  @return 网络请求任务
 */
+ (id)getZBItemWithTag:(NSString *)tag kCompletionHandle;
/**
 *  获取装备详情
 *
 *  @param Id 装备ID
 *
 *  @return 网络请求任务
 */
+ (id)getItemDetailWithId:(NSInteger)Id kCompletionHandle;
/**
 *  获取天赋
 */
+ (id)getGiftWithCompletionHandle:(void(^)(id model, NSError *error))completionHandle;
/**
 *  获取符文列表
 */
+ (id)getRuneWithCompletionHandle:(void(^)(id model, NSError *error))completionHandle;
/**
 *  获取召唤师技能列表
 */
+ (id)getSumAbilityWithCompletionHandle:(void(^)(id model, NSError *error))completionHandle;
/**
 *  获取最佳阵容
 */
+ (id)getBestGroupWithCompletionHandle:(void(^)(id model, NSError *error))completionHandle;

@end
