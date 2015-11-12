//
//  ZBCategoryViewModel.h
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "DuoWanNetManager.h"
@interface ZBCategoryViewModel : BaseViewModel

@property (nonatomic) NSInteger rownNumber;
/** tag 标识 */
- (NSString *)tagForRow:(NSInteger)row;
/** 文本内容 */
- (NSString *)textForRow:(NSInteger)row;
@end
