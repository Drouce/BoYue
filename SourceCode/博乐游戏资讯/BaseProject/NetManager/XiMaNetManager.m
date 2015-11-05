//
//  XiMaNetManager.m
//  BaseProject
//
//  Created by drouce on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "XiMaNetManager.h"

#define kRankListPath @"http://mobile.ximalaya.com/mobile/discovery/v1/rankingList/album"
#define kAlbunPath @"http://mobile.ximalaya.com/mobile/others/ca/album/track/%ld/true/%ld/20"
@implementation XiMaNetManager


+(id)getRankListWithPageId:(NSInteger)pageId completionHandle:(void (^)(id, NSError *))completionHandle {
    
    NSDictionary *params = @{@"device":@"iPhone",@"key":@"ranking:album:played:1:2",@"pageId":@(pageId),@"pageSize":@20,@"position":@0,@"title":@"排行榜"};
    return [self GET:kRankListPath parameters:params completionHandler:^(id responseObj, NSError *error) {
        completionHandle([RankingListModel objectWithKeyValues:responseObj],error);
    }];
}

+(id)getAlbumWithId:(NSInteger)Id page:(NSInteger)pageId completionHandle:(void (^)(id, NSError *))completionHandle {
    
    NSString *path = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%ld/true/%ld/20",Id,pageId];
    NSDictionary *params = @{@"device":@"iPhone"};
    return [self GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
        
        completionHandle([AlbumModel objectWithKeyValues:responseObj],error);
    }];
    
}
@end
