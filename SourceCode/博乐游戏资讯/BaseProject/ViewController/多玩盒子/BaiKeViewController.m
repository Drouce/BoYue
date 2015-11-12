//
//  BaiKeViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaiKeViewController.h"
#import "ToolMenuViewModel.h"
#import "DRImageView.h"
#import "TuWanHtmlViewController.h"
#import "BestGorupViewController.h"
#import "ZBCategoryViewController.h"
#import "SumAbilityViewController.h"


/** 创建自定义Cell 图+ 题目BaikeCell */
@interface BaiKeCell : UITableViewCell
@property (nonatomic, strong) DRImageView *iconIV;
@property (nonatomic, strong) UILabel *titleLb;
@end

@implementation BaiKeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (DRImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[DRImageView alloc] init];
        [self.contentView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(36, 36));
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _iconIV;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.iconIV.mas_right).mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
    }
    return _titleLb;
}

@end


@interface BaiKeViewController ()<UITableViewDelegate,UITableViewDataSource>
/** viewModel */
@property (nonatomic, strong)ToolMenuViewModel *toolVm;
/** table */
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BaiKeViewController

/** 实现viewModel懒加载 */
- (ToolMenuViewModel *)toolVm {
    if(_toolVm == nil) {
        _toolVm = [[ToolMenuViewModel alloc] init];
    }
    return _toolVm;
}

/** 实现tableview的懒加载：设置代理，去掉多余Cell、头部刷新，注册Cell */
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 67;
        [_tableView registerClass:[BaiKeCell class] forCellReuseIdentifier:@"baikeCell"];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
            [self.toolVm getDataFromNetCompleteHandle:^(NSError *error) {
               
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                } else {
                    [_tableView reloadData];
                }
                
                [_tableView.header endRefreshing];
            }];
        }];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

/** 实现tableview的协：区分割线，选择效果 */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.toolVm.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaiKeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baikeCell"];
    cell.titleLb.text = [self.toolVm titleForRow:indexPath.row];
    [cell.iconIV.imageView setImageWithURL:[self.toolVm iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    
    return cell;
}

kRemoveCellSeparator

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.toolVm toolMenuTypeForRow:indexPath.row] == ToolMenuTypeWeb) {
        TuWanHtmlViewController *tuwanVC = [[TuWanHtmlViewController alloc]initWithURL:[self.toolVm webURLForRow:indexPath.row]];
                                           
        tuwanVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tuwanVC animated:YES];
    }
    
    if ([[self.toolVm titleForRow:indexPath.row] isEqualToString:@"最佳阵容"]) {
        BestGorupViewController *bestVC = [[BestGorupViewController alloc]init];
        bestVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bestVC animated:YES];
    }
    
    if ([[self.toolVm titleForRow:indexPath.row] isEqualToString:@"装备"]) {
        ZBCategoryViewController *zbVC = [ZBCategoryViewController new];
        zbVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:zbVC animated:YES];
    }
    
    if ([[self.toolVm titleForRow:indexPath.row] isEqualToString:@"召唤师技能"]) {
        SumAbilityViewController *sumVC = [SumAbilityViewController new];
        sumVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sumVC animated:YES];
    }
    
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"游戏百科";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [Factory addMenuItemToVC:self];
    [self.tableView.header beginRefreshing];
    
}


@end
