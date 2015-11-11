//
//  ToolMenuViewModel.h
//  BaseProject
//
//  Created by drouce on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "DuoWanNetManager.h"
/** type de 枚举类型:web ,native */
typedef NS_ENUM(NSUInteger, ToolMenuType) {
    ToolMenuTypeNative,
    ToolMenuTypeWeb,
};


@interface ToolMenuViewModel : BaseViewModel
/** 有多少行 */
@property (nonatomic) NSInteger rowNumber;
/** 某行的图标 */
- (NSURL *)iconURLForRow:(NSInteger)row;
/** 某行的题目 */
- (NSString *)titleForRow:(NSInteger)row;
/** 某行的数据类型--枚举类型 */
- (ToolMenuType *)toolMenuTypeForRow:(NSInteger)row;
/** 某行的tag */
- (NSString *)tagForRow:(NSInteger)row;
/** 某行的URL */
- (NSURL *)webURLForRow:(NSInteger)row;
@end
