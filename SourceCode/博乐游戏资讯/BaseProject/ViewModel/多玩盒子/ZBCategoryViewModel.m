//
//  ZBCategoryViewModel.m
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ZBCategoryViewModel.h"
#import "ZBCategoryModel.h"
@implementation ZBCategoryViewModel

-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [DuoWanNetManager getZBCategoryWithCompletionHandle:^(id model, NSError *error) {
        if (!error) {
            self.dataArr = model;
        }
        completionHandle(error);
    }];
}

- (ZBCategoryModel *)modelForRow:(NSInteger)row {
    return self.dataArr[row];
}

-(NSString *)tagForRow:(NSInteger)row {
    return [self modelForRow:row].tag;
}

-(NSString *)textForRow:(NSInteger)row {
    return [self modelForRow:row].text;
}

-(NSInteger)rownNumber {
    return self.dataArr.count;
}
@end
