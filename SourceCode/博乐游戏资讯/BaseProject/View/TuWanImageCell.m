//
//  TuWanImageCell.m
//  BaseProject
//
//  Created by drouce on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanImageCell.h"

@implementation TuWanImageCell

//图片懒加载
- (UIImageView *)iconIV0 {
    if (!_iconIV0) {
        _iconIV0 = [[UIImageView alloc]init];
        _iconIV0.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconIV0;
}

- (UIImageView *)iconIV1 {
    if (!_iconIV1) {
        _iconIV1 = [[UIImageView alloc]init];
        _iconIV1.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconIV1;
}

- (UIImageView *)iconIV2 {
    if (!_iconIV2) {
        _iconIV2 = [[UIImageView alloc]init];
        _iconIV2.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconIV2;
}

//题目和点击数懒加载
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]init];
        _titleLb.font = [UIFont systemFontOfSize:17];
        
    }
    return _titleLb;
}

- (UILabel *)clicksNumLb {
    if (!_clicksNumLb) {
        _clicksNumLb = [[UILabel alloc]init];
        _clicksNumLb.font = [UIFont systemFontOfSize:13];
        _clicksNumLb.textColor = kRGBColor(233, 233, 233);
        
    }
    return _clicksNumLb;
}


//初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ( self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconIV0];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.iconIV1];
        [self.contentView addSubview:self.iconIV2];
        [self.contentView addSubview:self.clicksNumLb];
        
        //图片0 宽高等，间距5，边缘10，高度88
        [self.iconIV0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(88);
            make.top.mas_equalTo(_titleLb.mas_bottom).mas_equalTo(5);
        }];
        
        
        //图片1
        [self.iconIV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(_iconIV0);
            make.left.mas_equalTo(_iconIV0.mas_right).mas_equalTo(5);
            make.topMargin.mas_equalTo(_iconIV0.mas_topMargin);
        }];
        
        //图片2
        [self.iconIV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(_iconIV0);
            make.left.mas_equalTo(_iconIV1.mas_right).mas_equalTo(5);
            make.topMargin.mas_equalTo(_iconIV0.mas_topMargin);
            make.right.mas_equalTo(-10);
        }];

        
        //题目 左上10，右边10
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(_clicksNumLb.mas_left).mas_equalTo(-10);
            
        }];
        
        //点击数，上右10 ，宽度最大70，最小40
        [self.clicksNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.width.mas_greaterThanOrEqualTo(40).mas_lessThanOrEqualTo(70);
        }];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
