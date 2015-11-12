//
//  BestGroupCell.h
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRImageView.h"

@interface BestGroupCell : UITableViewCell
@property (nonatomic, strong) DRImageView *iconView1;
@property (nonatomic, strong) DRImageView *iconView2;
@property (nonatomic, strong) DRImageView *iconView3;
@property (nonatomic, strong) DRImageView *iconView4;
@property (nonatomic, strong) DRImageView *iconView5;

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *descLb;

@end
