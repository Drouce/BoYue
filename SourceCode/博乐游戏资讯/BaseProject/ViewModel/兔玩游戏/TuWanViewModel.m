//
//  TuWanViewModel.m
//  BaseProject
//
//  Created by drouce on 15/11/5.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanViewModel.h"

@implementation TuWanViewModel


-(instancetype)initWithType:(TuWanListType)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

//预防性编程，防止没有使用initWithType；
- (id)init {
    if (self = [super init]) {
        //如果使用该初始化方法，就会崩溃
        NSAssert1(NO, @"%s 必须使用initWithType初始化", __func__);
    }
    return self;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [TuWanNetManager getToWanListType:_type Start:_start completionHandle:^(TuWanModel *model, NSError *error) {
       
        if (!_start) {
            [self.dataArr removeAllObjects];
            self.indexPicArr = nil;
        }
        
        [self.dataArr addObjectsFromArray:model.data.list];
        self.indexPicArr = model.data.indexpic;
        completionHandle(error);
    }];
}

-(void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle {
    _start += 11;
    [self getDataFromNetCompleteHandle:completionHandle];
}

-(void)refreshDataCompletionHandle:(CompletionHandle)completionHandle {
    _start = 0;
    [self getDataFromNetCompleteHandle:completionHandle];
}

- (BOOL)isExitIndexPic {
    return self.indexPicArr != nil && self.indexPicArr.count != 0;
}

- (TuWanDataIndexpicModel *)modelForArr:(NSArray *)arr row:(NSInteger)row {
    return arr[row];
}



-(BOOL)ContainImages:(NSInteger)row {
    
    return [[self modelForArr:self.dataArr row:row].showtype isEqualToString:@"1"];
}

-(NSInteger)rowNumber {
    return self.dataArr.count;
}


//展示栏
-(NSString *)titleForRowIndexPic:(NSInteger)row {
    return [self modelForArr:self.indexPicArr row:row].title;
}
-(NSURL *)iconURLForRowIndexPic:(NSInteger)row {
    return [NSURL URLWithString:[self modelForArr:self.indexPicArr row:row].litpic];
}
-(NSInteger)indexPicNumber {
    return self.indexPicArr.count;
}
- (NSURL *)detailURLForRowIndexPic:(NSInteger)row {
    return [NSURL URLWithString:[self modelForArr:self.indexPicArr row:row].html5];
}


//列表中
-(NSString *)titleForRowInList:(NSInteger)row {
    return [self modelForArr:self.dataArr row:row].title;
}

-(NSURL *)iconURLForRowInList:(NSInteger)row {
    return [NSURL URLWithString:[self modelForArr:self.dataArr row:row].litpic];
}

- (NSString *)descForRowInList:(NSInteger)row {
    return [self modelForArr:self.dataArr row:row].desc;
}
-(NSString *)clickForRowInList:(NSInteger)row {
    return [self modelForArr:self.dataArr row:row].click;
}
-(NSURL *)detailURLForRowInList:(NSInteger)row {
    return [NSURL URLWithString:[self modelForArr:self.dataArr row:row].html5];
}
- (NSArray *)iconURLSForRowInList:(NSInteger)row {
    
    NSArray *arr = [self modelForArr:self.dataArr row:row].showitem;
    NSMutableArray *mutableArr = [NSMutableArray new];
    for (int i = 0; i < arr.count; i ++) {
        TuWanDataIndexpicShowitemModel *model = arr[i];
        [mutableArr addObject:[NSURL URLWithString:model.pic]];
    }
    return [mutableArr copy];
}


//判断数据类型
-(BOOL)isVideoInIndexPicForRow:(NSInteger)row {
    return  [[self modelForArr:self.indexPicArr row:row].type isEqualToString:@"video"];
}
-(BOOL)isVideoInListForRow:(NSInteger)row {
    return  [[self modelForArr:self.dataArr row:row].type isEqualToString:@"video"];
}

-(BOOL)isPicInIndexPicForRow:(NSInteger)row {
    return  [[self modelForArr:self.indexPicArr row:row].type isEqualToString:@"pic"];
}
-(BOOL)isPicInListForRow:(NSInteger)row {
    return  [[self modelForArr:self.dataArr row:row].type isEqualToString:@"pic"];
}
-(BOOL)isHtmlInIndexPicForRow:(NSInteger)row {
   return  [[self modelForArr:self.indexPicArr row:row].type isEqualToString:@"all"];
}
-(BOOL)isHtmlInListForRow:(NSInteger)row {
    return  [[self modelForArr:self.dataArr row:row].type isEqualToString:@"all"];
}


//返回某行的aid
- (NSString *)aidInListFowRow:(NSInteger)row {
    return [self modelForArr:self.dataArr row:row].aid;
}
- (NSString *)aidIndexPicFowRow:(NSInteger)row {
    return [self modelForArr:self.indexPicArr row:row].aid;

}
@end
