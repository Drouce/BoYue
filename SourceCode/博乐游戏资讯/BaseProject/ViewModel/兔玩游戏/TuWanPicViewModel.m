//
//  TuWanPicViewModel.m
//  BaseProject
//
//  Created by drouce on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanPicViewModel.h"
#import "TuWanNetManager.h"

@implementation TuWanPicViewModel

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle {
    self.dataTask = [TuWanNetManager getPicDetailWithId:_aid completionHandle:^(id model, NSError *error) {
        self.picModel = model;
        completionHandle(error);
        
    }];
}

-(instancetype)initWithAid:(NSString *)aid {
    if (self = [super init]) {
        self.aid = aid;
    }
    return self;
}
/** 防御性编程，不允许使用init初始化 */
- (id)init {
    if (self = [super init]) {
        NSAssert1(NO, @"%s 必须使用initWithAid", __func__);
    }
    return self;
}


-(NSInteger)rowNumber {
    return self.picModel.content.count;
}

-(NSURL *)PicURLFowRow:(NSInteger)row {
    TuWanPicContentModel *model = self.picModel.content[row];
    return [NSURL URLWithString:model.pic];
}

@end
