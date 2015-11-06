//
//  TuWanListCell.m
//  BaseProject
//
//  Created by drouce on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanListCell.h"

@implementation TuWanListCell

- (DRImageView *)iconIV {
    if (!_iconIV) {
        _iconIV = [[DRImageView alloc]init];
        //_iconIV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconIV;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]init];
        _titleLb.font = [UIFont systemFontOfSize:17];
        
    }
    return _titleLb;
}

- (UILabel *)longTitleLb {
    if (!_longTitleLb) {
        _longTitleLb = [[UILabel alloc]init];
        _longTitleLb.font = [UIFont systemFontOfSize:15];
        _longTitleLb.textColor = kRGBColor(180, 180, 180);
        _longTitleLb.numberOfLines = 0;
        
    }
    return _longTitleLb;
}

- (UILabel *)clicksNumLb {
    if (!_clicksNumLb) {
        _clicksNumLb = [[UILabel alloc]init];
        _clicksNumLb.font = [UIFont systemFontOfSize:13];
        _clicksNumLb.textColor = kRGBColor(190, 190, 190);

    }
    return _clicksNumLb;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ( self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
          [self.contentView addSubview:self.iconIV];
          [self.contentView addSubview:self.titleLb];
          [self.contentView addSubview:self.longTitleLb];
          [self.contentView addSubview:self.clicksNumLb];
        
        //图片 左 10， 宽高92，70 书香居中
        [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(94, 70));
            make.centerY.mas_equalTo(0);
        }];
        
        //题目 距离图片边缘8，右边10， 上比下边缘矮3
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconIV.mas_right).mas_equalTo(8);
            make.right.mas_equalTo(-10);
            make.topMargin.mas_equalTo(_iconIV.mas_topMargin).mas_equalTo(3);
        }];
        
        //长题目 左右边缘与题目一样，上边距离题目8，
        [self.longTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(_titleLb.mas_leftMargin);
            make.rightMargin.mas_equalTo(_titleLb.mas_rightMargin);
            make.top.mas_equalTo(_titleLb.mas_bottom).mas_equalTo(9);
            
        }];
        
        //点击数，下与图片对齐，右边与title对齐
        [self.clicksNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottomMargin.mas_equalTo(_iconIV.mas_bottomMargin);
            make.rightMargin.mas_equalTo(_titleLb.mas_rightMargin);
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
