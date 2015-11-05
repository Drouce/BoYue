//
//  XiMaNetManager.h
//  BaseProject
//
//  Created by drouce on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "RankingListModel.h"
#import "AlbumModel.h"

@interface XiMaNetManager : BaseNetManager

/**
 *  音乐分类列表
 *
 *  @param pageId 当前页数从1开始
 *
 *  @return 返回当前请求所在的任务
 */
+ (id)getRankListWithPageId:(NSInteger)pageId kCompletionHandle;

/**
 *  音乐分类内容
 *
 *  @param Id     音乐组ID
 *  @param pageId 当前页数，从1开始
 *
 *  @return 返回当前所在的任务
 */
+ (id)getAlbumWithId:(NSInteger)Id page:(NSInteger)pageId kCompletionHandle;
@end
