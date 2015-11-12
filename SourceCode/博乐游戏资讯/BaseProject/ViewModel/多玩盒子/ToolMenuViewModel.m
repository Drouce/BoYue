//
//  ToolMenuViewModel.m
//  BaseProject
//
//  Created by drouce on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ToolMenuViewModel.h"
#import "ToolMenuModel.h"

@implementation ToolMenuViewModel

/** 不是分页，只实现getDelegate方法即可 */

- (void) getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [DuoWanNetManager getToolMenuWithCompletionHandle:^(id model, NSError *error) {
        self.dataArr = model;
        completionHandle(error);
    }];
}

- (ToolMenuModel *)modelForRow:(NSInteger)row {
    return self.dataArr[row];
}

-(NSInteger)rowNumber {
    return self.dataArr.count;
}

-(NSString *)titleForRow:(NSInteger)row {
    return [self modelForRow:row].name;
}

-(NSString *)tagForRow:(NSInteger)row {
    return [self modelForRow:row].tag;
}

-(NSURL *)iconURLForRow:(NSInteger)row {
    return [NSURL URLWithString:[self modelForRow:row].icon];
}

-(NSURL *)webURLForRow:(NSInteger)row {
    return [NSURL URLWithString:[self modelForRow:row].url];
}

-(ToolMenuType)toolMenuTypeForRow:(NSInteger)row {
    
    NSString *type = [self modelForRow:row].type;
    if ([type isEqualToString:@"native"]){
        return ToolMenuTypeNative;
    }
    if ([type isEqualToString:@"web"]) {
         return ToolMenuTypeWeb;
    }
    return 0;
    
}
    
@end
