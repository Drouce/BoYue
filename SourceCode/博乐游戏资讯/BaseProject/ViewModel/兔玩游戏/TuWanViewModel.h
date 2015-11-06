//
//  TuWanViewModel.h
//  BaseProject
//
//  Created by drouce on 15/11/5.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "TuWanNetManager.h"
@interface TuWanViewModel : BaseViewModel

@property (nonatomic) NSInteger start;

@property (nonatomic) NSInteger rowNumber;

/** 存放头部滚动栏 */
@property (nonatomic, strong) NSArray *indexPicArr;
/** 是否有头部滚动栏 */
@property (nonatomic, getter=isExitIndexPic) BOOL exitIndexPic;

/** 必须使用初始化方法，需要一个类型 */
- (instancetype)initWithType:(TuWanListType)type;
@property (nonatomic) TuWanListType type;


/** 判断某一行数据是否有图 */
- (BOOL)ContainImages:(NSInteger)row;


/** 返回列表中某行数据题目 */
- (NSString *)titleForRowInList:(NSInteger)row;
/** 返回列表中某行数据的图片 */
- (NSURL *)iconURLForRowInList:(NSInteger)row;
/** 返回列表中某行数据的浏览人数 */
- (NSString *)clickForRowInList:(NSInteger)row;
/** 返回列表中某行数据的描述 */
- (NSString *)descForRowInList:(NSInteger)row;


/** 滚动展示栏的图片 */
- (NSURL *)iconURLForRowIndexPic:(NSInteger)row;
/** 滚动展示栏的文字 */
- (NSString *)titleForRowIndexPic:(NSInteger)row;
/** 滚动展示栏的图片数量 */
@property (nonatomic) NSInteger indexPicNumber;
/** 获取列表中某行数据对应的HTML5链接 */
- (NSURL *)detailURLForRowInList:(NSInteger)row;
/** 获取展示栏中某行数据对应的HTML5链接 */
- (NSURL *)detailURLForRowIndexPic:(NSInteger)row;


/** 通过行数返回此行中对应的图片链接数组 */
- (NSArray *)iconURLSForRowInList:(NSInteger)row;

/** 当前数据是视频  video*/
- (BOOL) isVideoInListForRow:(NSInteger)row;
- (BOOL) isVideoInIndexPicForRow:(NSInteger)row;
/** 当前数据是图片 pic */
- (BOOL) isPicInListForRow:(NSInteger)row;
- (BOOL) isPicInIndexPicForRow:(NSInteger)row;
/** 当前数据类型是HTML all */
- (BOOL) isHtmlInListForRow:(NSInteger)row;
- (BOOL) isHtmlInIndexPicForRow:(NSInteger)row;
@end
