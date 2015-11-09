//
//  XiMaCategoryViewModel.m
//  BaseProject
//
//  Created by drouce on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "XiMaCategoryViewModel.h"

@implementation XiMaCategoryViewModel

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle {
    _pageId = 1;
    [self getDataFromNetCompleteHandle:completionHandle];
}

-(void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle {
    
    //当前页数已经是最大的额页数，没有必要在发送请求，这样会浪费用户流量
    if (_maxPageId <= _pageId) {
        
        NSError *error = [NSError errorWithDomain:@"" code:999 userInfo:@{NSLocalizedDescriptionKey:@"没有更多数据"}];
        
        completionHandle(error);
        return;
    }
    _pageId +=1;
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [XiMaNetManager getRankListWithPageId:_pageId completionHandle:^(RankingListModel *model, NSError *error) {
        
        if (!error) {
            if (_pageId == 1 ) {
                [self.dataArr removeAllObjects];
                
            }
            [self.dataArr addObjectsFromArray:model.list];
            _maxPageId = model.maxPageId;
        }
        
        completionHandle(error);
    }];
}


- (RankListListModel *)modelForRow:(NSInteger)row {
    return self.dataArr[row];
}

-(NSInteger)rowNumber {
    return self.dataArr.count;
}

-(NSInteger)albumIDForRow:(NSInteger)row {
    return [self modelForRow:row].albumId;
}

- (NSURL *)iconURLForRow:(NSInteger)row {
    return [NSURL URLWithString:[self modelForRow:row].albumCoverUrl290];
}

-(NSString *)titleForRow:(NSInteger)row {
    return [self modelForRow:row].title;
}

- (NSString *)descForRow:(NSInteger)row {
    return [self modelForRow:row].intro;
}

-(NSString *)numberForRow:(NSInteger)row {
    return [NSString stringWithFormat:@"%ld集数",[self modelForRow:row].tracks];
}


@end
