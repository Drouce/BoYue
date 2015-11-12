//
//  ZBItemViewModel.h
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "DuoWanNetManager.h"
@interface ZBItemViewModel : BaseViewModel

@property (nonatomic) NSInteger rowNumber;

- (NSURL *)iconURLForRow:(NSInteger)row;
- (NSString *)itemNameForRow:(NSInteger)row;
- (NSInteger)itemIDForRow:(NSInteger)row;


- (instancetype)initWithTag:(NSString *)tag;
@property (nonatomic, strong) NSString *tag;




@end
