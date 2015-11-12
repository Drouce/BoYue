//
//  SumabilityDetailViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "SumabilityDetailViewController.h"
#import "DRImageView.h"

@interface SumAbilityCell : UITableViewCell
@property (nonatomic, strong)UILabel *descLb;
@end


@implementation SumAbilityCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}




- (UILabel *)descLb {
    if(_descLb == nil) {
        
        _descLb = [[UILabel alloc] init];
        _descLb.font = [UIFont systemFontOfSize:14];
        
        //制作边框
        
        UIView *graryView = [UIView new];
        graryView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:graryView];
        graryView.layer.cornerRadius = 5;
        [graryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(3, 10, 3, 10));
        }];
        
        UIView *whiteView = [UIView new];
        whiteView.backgroundColor = [UIColor whiteColor];
        [graryView addSubview:whiteView];
        whiteView.layer.cornerRadius = 5;
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(1, 1, 1, 1));
        }];
        
        
        [whiteView addSubview:_descLb];
        _descLb.numberOfLines = 0;
        [_descLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    }
    return _descLb;
}


@end



@interface SumabilityDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topView;

@end

@implementation SumabilityDetailViewController


-(instancetype)initWithSumAbilityModel:(SumAbilityModel *)abilityModel {
    if (self = [super init]) {
        self.abilityModel = abilityModel;
        [Factory addBackItemToVC:self];
        self.title = @"召唤师技能";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kRGBColor(246, 247, 251);
    [self.tableView.header beginRefreshing];
    
}



- (UIView *)topView {
    if(_topView == nil) {
        _topView = [[UIView alloc] init];
        [self.view addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(90);
        }];
        
        //技能图标
        DRImageView *imageView = [DRImageView new];
        [_topView addSubview:imageView];
        NSURL *iconURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.lolbox.duowan.com/spells/png/%@.png",_abilityModel.ID]];
        [imageView.imageView setImageWithURL:iconURL placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.left.top.mas_equalTo(8);
        }];
        
        //技能名称
        UILabel *abilityLb = [UILabel new];
        abilityLb.text = _abilityModel.name;
        [_topView addSubview:abilityLb];
        [abilityLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.topMargin.mas_equalTo(imageView);
        }];
        
        //需要等级
        UILabel *levelLb = [UILabel new];
        levelLb.text = [NSString stringWithFormat:@"需要等级 %@",_abilityModel.level];
        levelLb.font = [UIFont systemFontOfSize:12];
        levelLb.textColor = [UIColor lightGrayColor];
        [_topView addSubview:levelLb];
        [levelLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.rightMargin.mas_equalTo(abilityLb);
            make.top.mas_equalTo(abilityLb.mas_bottom).mas_equalTo(5);
        }];
        
        //冷却时间
        UILabel *coolLb = [UILabel new];
        [_topView addSubview:coolLb];
        coolLb.text = [NSString stringWithFormat:@"冷却时间 %@",_abilityModel.cooldown];
        coolLb.font = [UIFont systemFontOfSize:12];
        coolLb.textColor = [UIColor lightGrayColor];
        [coolLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.rightMargin.mas_equalTo(abilityLb);
            make.top.mas_equalTo(levelLb.mas_bottom).mas_equalTo(5);
        
        }];
        
    }
    return _topView;
}


- (UITableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        _tableView.sectionHeaderHeight = 25;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.bottom.right.mas_equalTo(0);
            make.top.mas_equalTo(self.topView.mas_bottom).mas_equalTo(0);
        }];
        [_tableView registerClass:[SumAbilityCell class] forCellReuseIdentifier:@"sumCell"];
	}
	return _tableView;
}

#pragma mark - uitableView协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *noView = [UIView new];
    noView.backgroundColor = [UIColor clearColor];
    
    UILabel *noLabel = [UILabel new];
    [noView addSubview:noLabel];
    noLabel.backgroundColor = [UIColor clearColor];
    noLabel.text = @[@"描述",@"天赋强化",@"提示"][section];
    noLabel.font = [UIFont systemFontOfSize:13];
    noLabel.textColor = [UIColor lightGrayColor];
    [noLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    return noView;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SumAbilityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sumCell"];
    if (indexPath.section == 0) {
        cell.descLb.text = _abilityModel.des;
    }
    if (indexPath.section == 1) {
        cell.descLb.text = _abilityModel.strong;
    }
    if (indexPath.section == 2) {
        cell.descLb.text = _abilityModel.tips;
    }
    
    return cell;
}



@end
