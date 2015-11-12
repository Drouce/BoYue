//
//  SumAblityViewModel.h
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "DuoWanNetManager.h"

@interface SumAblityViewModel : BaseViewModel

@property (nonatomic) NSInteger rowNumber;

/** 返回某行数据，主要用于页面传值 */
- (SumAbilityModel *)modelForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSURL *)iconURLForRow:(NSInteger)row;

@end
