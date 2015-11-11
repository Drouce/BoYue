//
//  TXiMaAlbumCell.h
//  BaseProject
//
//  Created by drouce on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXiMaAlbumCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconIV;

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UILabel *nickName;
/** 时长 */
@property (nonatomic) float duration;
@end
