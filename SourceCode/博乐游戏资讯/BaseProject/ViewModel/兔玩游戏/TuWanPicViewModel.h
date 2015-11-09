//
//  TuWanPicViewModel.h
//  BaseProject
//
//  Created by drouce on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "TuWanNetManager.h"

@interface TuWanPicViewModel : BaseViewModel

/** 必须使用下方初始化方法 */

- (instancetype)initWithAid:( NSString *)aid;
@property (nonatomic, strong)  NSString *aid;

@property (nonatomic) NSInteger rowNumber;
- (NSURL *)PicURLFowRow:(NSInteger)row;
@property (nonatomic, strong) TuWanPicModel *picModel;
@end
