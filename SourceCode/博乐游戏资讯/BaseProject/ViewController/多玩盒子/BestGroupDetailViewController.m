//
//  BestGroupDetailViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BestGroupDetailViewController.h"
#import "BestGroupIntroCell.h"
#import "BestGroupDetailHeroCell.h"

@interface BestGroupDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BestGroupDetailViewController

-(instancetype)initWithTitle:(NSString *)titleLb desc:(NSString *)desc icons:(NSArray *)icons decscs:(NSArray *)descs {
    if (self = [super init]) {
        self.titleLb = titleLb;
        self.desc = desc;
        self.icons = icons;
        self.descs = descs;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView reloadData];
    self.title = @"阵容详情";
    [Factory addBackItemToVC:self];
}

/**
 *  懒加载
 */
- (UITableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
        //去掉头部section和尾部section显示范围
        _tableView.contentInset = UIEdgeInsetsMake(-1, 0, -10, 0);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_tableView registerClass:[BestGroupIntroCell class] forCellReuseIdentifier:@"IntroCell"];
        [_tableView registerClass:[BestGroupDetailHeroCell class] forCellReuseIdentifier:@"HeroCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
	return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return _descs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BestGroupIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntroCell"];
        cell.titleLb.text = _titleLb;
        cell.descLb.text = _desc;
        
        NSArray *arr = @[cell.iconView1,cell.iconView2,cell.iconView3,cell.iconView4,cell.iconView5];
        [arr enumerateObjectsUsingBlock:^(DRImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.imageView setImageWithURL:_icons[idx] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
        }];
        return cell;
    }else {
        BestGroupDetailHeroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeroCell"];
        [cell.iconView.imageView setImageWithURL:_icons[indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
        cell.introLb.text = _descs[indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

@end
