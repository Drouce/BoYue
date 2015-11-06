//
//  TuWanImageCell.h
//  BaseProject
//
//  Created by drouce on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRImageView.h"
@interface TuWanImageCell : UITableViewCell


/** 图片1 */
@property (nonatomic, strong) DRImageView *iconIV0;
/** 题目标签 */
@property (nonatomic, strong) UILabel *titleLb;
/** 图片2 */
@property (nonatomic, strong) DRImageView *iconIV1;
/** 点击数标签 */
@property (nonatomic, strong) UILabel *clicksNumLb;
/** 图片3 */
@property (nonatomic, strong) DRImageView *iconIV2;
@end
