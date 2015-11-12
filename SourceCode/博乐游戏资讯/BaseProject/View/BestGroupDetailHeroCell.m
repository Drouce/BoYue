//
//  BestGroupDetailHeroCell.m
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BestGroupDetailHeroCell.h"

@implementation BestGroupDetailHeroCell


- (UILabel *)introLb {
    if(_introLb == nil) {
        _introLb = [[UILabel alloc] init];
        [self.contentView addSubview:_introLb];
        [_introLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.bottom.right.mas_equalTo(-10);
            make.left.mas_equalTo(self.iconView.mas_right).mas_equalTo(10);
        }];
        
        _introLb.numberOfLines = 0;
        _introLb.font = [UIFont systemFontOfSize:16];
    }
    return _introLb;
}

- (DRImageView *)iconView {
    if(_iconView == nil) {
        _iconView = [[DRImageView alloc] init];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(52, 52));
            make.top.left.mas_equalTo(10);
        }];
    }
    return _iconView;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *redVivew = [UIView new];
        redVivew.backgroundColor = kRGBColor(254, 249, 236);
        self.selectedBackgroundView = redVivew;
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
