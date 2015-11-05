//
//  TuWanNetManager.m
//  BaseProject
//
//  Created by drouce on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanNetManager.h"

#define kTuWanPath @"http://cache.tuwan.com/app/"
#define kAppId  @"appid":@1
#define kAppVer @"appver":@2.1
#define kClassMore @"classmore":@"indexpic"

#define kRemoveClassMore(dic)        [dic removeObjectForKey:@"classmore"];
#define kSetDtId(string, dic)        [dic setObject:string forKey:@"dtid"];
#define kSetClass(string, dic)       [dic setObject:string forKey:@"class"];
#define kSetMod(string, dic)         [dic setObject:string forKey:@"mod"];
#define kSetType(string, dic)         [dic setObject:string forKey:@"type"];


@implementation TuWanNetManager

+(id)getToWanListType:(TuWanListType)type Start:(NSInteger)start completionHandle:(void (^)(id, NSError *))completionHandle {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary: @{kAppId,kAppVer,@"start":@(start),kClassMore}];
    
    switch (type) {
        case TuWanListTypeTouTiao: {
            break;
        }
        case TuWanListTypeDuJia: {
            kSetClass(@"heronews", params)
            kSetMod(@"八卦", params)
            kRemoveClassMore(params)
            break;
        }
        case TuWanListTypeAnHei3: {
            kSetDtId(@"83623", params)
            break;
        }
        case TuWanListTypeMoShou: {
            kSetDtId(@"31537", params)
            break;
        }
        case TuWanListTypeFengBao: {
            kSetDtId(@"31538", params)
            break;
        }
        case TuWanListTypeLuShi: {
            kSetDtId(@"31528", params)
            break;
        }
        case TuWanListTypeXingJi2: {
            kRemoveClassMore(params)
            kSetDtId(@"91821", params)
            break;
        }
        case TuWanListTypeShouWang: {
            kRemoveClassMore(params)
            kSetDtId(@"57067", params)
            break;
        }
        case TuWanListTypeTuPian:
        case TuWanListTypeShiPian:
        case TuWanListTypeGongLue:{
            if (type == TuWanListTypeTuPian) {
                kSetType(@"pic", params)
            }
            if (type == TuWanListTypeShiPian) {
                kSetType(@"video", params)
            }
            if (type == TuWanListTypeGongLue) {
                kSetType(@"guide", params)
            }
             kRemoveClassMore(params)
             kSetDtId(@"83623,31528,31537,31538,57067,91821", params)
            break;
        }
        case TuWanListTypeHuanHua: {
            kRemoveClassMore(params)
            kSetMod(@"幻化", params)
            kSetClass(@"heronews", params)
            break;
        }
        case TuWanListTypeQuWen: {
            kSetDtId(@"0", params)
            kSetClass(@"heronews", params)
            kSetMod(@"趣闻", params)
            break;
        }
        case TuWanListTypeCOS: {
            kSetDtId(@"0", params)
            kSetClass(@"cos", params)
            kSetMod(@"cos", params)
            break;
        }
        case TuWanListTypeMeiNv: {
            kSetClass(@"heronews", params)
            kSetMod(@"美女", params)
            [params setObject:@"cos1" forKey:@"typechild"];
            break;
        }
        default: {
            break;
        }
    }
    
    //🐰玩服务器要求传入参数，不能为中文，要转换%形式
    NSString *path = [self percentPathWithPath:kTuWanPath params:params];
    
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        
        completionHandle([TuWanModel objectWithKeyValues:responseObj],error);
    }];

}
@end
