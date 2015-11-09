//
//  TuWanNetManager.h
//  BaseProject
//
//  Created by drouce on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "TuWanModel.h"
#import "TuWanPicModel.h"
#import "TuWanVideoModel.h"

//只要公用一个解析类的请求，就可以合起来写，只需要使用枚举变量，来决定不同的请求地址：参考汽车之家
typedef NS_ENUM(NSUInteger, TuWanListType) {
    TuWanListTypeTouTiao,  //头条
    TuWanListTypeDuJia,    //独家
    TuWanListTypeAnHei3,   //暗黑3
    TuWanListTypeMoShou,   //魔兽
    TuWanListTypeFengBao,  //风暴
    TuWanListTypeLuShi,    //炉石
    TuWanListTypeXingJi2,  //星际2
    TuWanListTypeShouWang, //守望
    TuWanListTypeTuPian,   //图片
    TuWanListTypeShiPian,  //视频
    TuWanListTypeGongLue,  //攻略
    TuWanListTypeHuanHua,  //幻化
    TuWanListTypeQuWen,    //趣闻
    TuWanListTypeCOS,      //COS
    TuWanListTypeMeiNv     //美女
};


@interface TuWanNetManager : BaseNetManager
//通过type来区分 请求的地址
+ (id)getToWanListType:(TuWanListType)type Start:(NSInteger)start kCompletionHandle;

/**
 *  获取视频类资讯的详情页
 *
 *  @param aid 资讯aid
 *
 *  @return 任务
 */
+ (id)getVideoDetailWithId:(NSString *)aid kCompletionHandle;

/**
 *  获取图片类资讯的详情页
 *
 *  @param aid 资讯aid
 *
 *  @return 任务
 */
+ (id)getPicDetailWithId:(NSString *)aid kCompletionHandle;


@end
