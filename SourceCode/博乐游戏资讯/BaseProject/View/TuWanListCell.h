//
//  TuWanListCell.h
//  BaseProject
//
//  Created by drouce on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRImageView.h"

@interface TuWanListCell : UITableViewCell
/** 左侧图片 */
@property (nonatomic, strong) DRImageView *iconIV;
/** 题目标签 */
@property (nonatomic, strong) UILabel *titleLb;
/** 长题目标签 */
@property (nonatomic, strong) UILabel *longTitleLb;
/** 点击数标签 */
@property (nonatomic, strong) UILabel *clicksNumLb;
@end
