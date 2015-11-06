//
//  DRImageView.m
//  BaseProject
//
//  Created by drouce on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DRImageView.h"

@implementation DRImageView



-(instancetype)init {
    if (self = [super init]) {
        _imageView = [UIImageView new];
        
        //按比例充满
        _imageView.contentMode = 2;
        [self addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        //当前视图容易减掉超出自身区域的部分
        self.clipsToBounds = YES;
    }
    return self;
}

@end
