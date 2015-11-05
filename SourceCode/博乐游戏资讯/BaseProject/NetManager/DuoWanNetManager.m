//
//  DuoWanNetManager.m
//  BaseProject
//
//  Created by drouce on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DuoWanNetManager.h"
#import "DuoWanRequest.h"

//很多具有共同点的东西，可以统一宏定义，比如：(凡是自己写的宏定义都需要用k开头，编码习惯)
#define kOSType  @"OSType":[@"iOS" stringByAppendingString:\
[UIDevice currentDevice].systemVersion]//获取当前系统的版本号

#define kVersionName  @"versionName" :@"2.4.0"
#define kV  @"v" : @140
//把path写到文件头部，使用宏定义形式，方便后期维护
//把所有路径封装到DuoWanRequest.h中，以免太乱。
@implementation DuoWanNetManager


+(id)getHeroWithType:(HeroType)heroType completionHandle:(void (^)(id, NSError *))completionHandle {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{kOSType,kV}];
    switch (heroType) {
        case HeroTypeFree: {
            [params setObject:@"free" forKey:@"type"];
            break;
        }
        case HeroTypeAll: {
            [params setObject:@"all" forKey:@"type"];
            break;
        }
        default: {
            NSAssert1(NO, @"%s:type类型不正确", __func__);
            break;
        }
    }
    
    //json
    return [self GET:kHeroPath parameters:params completionHandler:^(id responseObj, NSError *error) {
       
        switch (heroType) {
            case HeroTypeFree: {
                completionHandle([FreeHeroModel objectWithKeyValues:responseObj],error);
                break;
            }
            case HeroTypeAll: {
                completionHandle([AllHeroModel objectWithKeyValues:responseObj],error);
                break;
            }
            default: {
                completionHandle(nil,error);
                break;
            }
        }
    }];
    
}


+(id)getHeroSkinsWithHeroName:(NSString *)heroName completionHandle:(void (^)(id, NSError *))completionHandle {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{kV,kOSType,kVersionName,@"hero":heroName}];
    return [self GET:kHeroSkinPath parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroSkinModel objectArrayWithKeyValuesArray:responseObj],error);
    }];
}



+ (id)getHeroSoundWithHeroName:(NSString *)heroName kCompletionHandle {
    return [self GET:kHeroSoundPath parameters:@{@"hero":heroName, kV, kOSType,kVersionName} completionHandler:^(id responseObj, NSError *error) {
        //他的json数据就是标准的数组，不需要解析
        completionHandle(responseObj,error);
    }];
}
+ (id)getHeroVideoPage:(NSInteger)page tag:(NSString *)heroNmae kCompletionHandle{
    
    return [self GET:kHeroVideoPath parameters:@{@"action":@"l",kV,kOSType,
    @"p":@(page),@"tag":heroNmae,@"src":@"letv"} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroVideoModel objectArrayWithKeyValuesArray:responseObj],error);
    }];
}
+ (id)getHeroCZWithHeroName:(NSString *)heroName kCompletionHandle {
    return [self GET:kHeroCZPath parameters:@{@"limit":@7,kV,kOSType,
    @"championName":heroName} completionHandler:^(id responseObj, NSError *error) {
    completionHandle([HeroCZModel objectArrayWithKeyValuesArray:responseObj],error);
    }];
}
+ (id)getHeroDetailWithHeroName:(NSString *)heroName kCompletionHandle {
    return [self GET:kHeroDetailPath parameters:@{kOSType,kV,@"heroName":heroName} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroDetailModel objectWithKeyValues:responseObj],error);
    }];
}
+ (id)getHeroGiftWithHeroName:(NSString *)heroName kCompletionHandle {
    return [self GET:kGiftAndRunPath parameters:@{@"hero":heroName,kV,kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroGiftModel objectArrayWithKeyValuesArray:responseObj],error);
    }];
}
+ (id)getHeroChangeWithHeroName:(NSString *)heroName kCompletionHandle {
    return [self GET:kHeroInfoPath parameters:@{@"name":heroName,kV,kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroChangeModel objectWithKeyValues:responseObj],error);
    }];
}
+ (id)getHeroWeekDataWithId:(NSInteger)heroId kCompletionHandle {
    return [self GET:kHeroWeekDataPath parameters:@{@"heroId":@(heroId)} completionHandler:^(id responseObj,NSError *error) {
        completionHandle([HeroWeekDataModel objectWithKeyValues:responseObj],error);
    }];
}
+ (id)getToolMenuWithCompletionHandle:(void(^)(id model,NSError *error))completionHandle {
    return [self GET:kToolMenuPath parameters:@{kV,kOSType,kVersionName,@"category":@"database"} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ToolMenuModel objectArrayWithKeyValuesArray:responseObj],error);
    }];
}
+ (id)getZBCategoryWithCompletionHandle:(void(^)(id model, NSError *error))completionHandle {
    return [self GET:kZBCategoryPath parameters:@{kVersionName,kOSType,kV} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ZBCategoryModel objectArrayWithKeyValuesArray:responseObj],error);
    }];
}
+ (id)getZBItemWithTag:(NSString *)tag kCompletionHandle {
    return [self GET:kZBItemListPath parameters:@{@"tag":tag,kV,kOSType,kVersionName} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ZBItemModel objectArrayWithKeyValuesArray:responseObj],error);
    }];
}
+ (id)getItemDetailWithId:(NSInteger)Id kCompletionHandle {
    return [self GET:kItemDetailPath parameters:@{@"id":@(Id),kV,kOSType} completionHandler:^(id responseObj, NSError *error) {
    completionHandle([ItemDetailModel objectWithKeyValues:responseObj],error);
    }];
}

+ (id)getGiftWithCompletionHandle:(void(^)(id model, NSError *error))completionHandle {
    return [self GET:kGiftPath parameters:@{kV,kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([GiftModel objectWithKeyValues:responseObj],error);
    }];
}
    
+ (id)getRuneWithCompletionHandle:(void(^)(id model, NSError *error))completionHandle {
    return [self GET:kRunesPath parameters:@{kV,kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([RuneModel objectWithKeyValues:responseObj],error);
    }];
}

+ (id)getSumAbilityWithCompletionHandle:(void(^)(id model, NSError *error))completionHandle {
    return [self GET:kSumAbilityPath parameters:@{kV,kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([SumAbilityModel objectArrayWithKeyValuesArray:responseObj],error);
    }];

}
+ (id)getBestGroupWithCompletionHandle:(void(^)(id model, NSError *error))completionHandle {
    return [self GET:kBestGroupPath parameters:@{kV,kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([BestGroupModel objectArrayWithKeyValuesArray:responseObj],error);
    }];
}

@end
