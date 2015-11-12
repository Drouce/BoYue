//
//  BestGorupViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BestGorupViewController.h"
#import "BestGroupViewModel.h"
#import "BestGroupCell.h"
#import "BestGroupDetailViewController.h"

@interface BestGorupViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) BestGroupViewModel *bestGroupVM;
@end

@implementation BestGorupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"最佳阵容";
    [Factory addBackItemToVC:self];
    [self.tableView.header beginRefreshing];
    
}

/** 懒加载 */

- (UITableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc] init];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        //_tableView.rowHeight = 60;
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           [self.bestGroupVM getDataFromNetCompleteHandle:^(NSError *error) {
               if (error) {
                   [self showErrorMsg:error.localizedDescription];
               } else {
                   [_tableView reloadData];
               }
               [_tableView.header endRefreshing];
           }];
        }];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_tableView registerClass:[BestGroupCell class] forCellReuseIdentifier:@"bestCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	}
	return _tableView;
}

- (BestGroupViewModel *)bestGroupVM {
	if(_bestGroupVM == nil) {
		_bestGroupVM = [[BestGroupViewModel alloc] init];
	}
	return _bestGroupVM;
}


#pragma mark - uiTableView协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bestGroupVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BestGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bestCell"];
    cell.titleLb.text = [self.bestGroupVM titleForRow:indexPath.row];
    cell.descLb.text = [self.bestGroupVM descForRow:indexPath.row];
    NSArray *arr = @[cell.iconView1,cell.iconView2,cell.iconView3,cell.iconView4,cell.iconView5];
    [arr enumerateObjectsUsingBlock:^(DRImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.imageView setImageWithURL:[self.bestGroupVM iconURLsForRow:indexPath.row][idx] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    }];
        
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BestGroupDetailViewController *VC = [[BestGroupDetailViewController alloc]initWithTitle:[self.bestGroupVM titleForRow:indexPath.row] desc:[self.bestGroupVM descForRow:indexPath.row] icons:[self.bestGroupVM iconURLsForRow:indexPath.row] decscs:[self.bestGroupVM descsForRow:indexPath.row]];
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 *  自适应行高
 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
@end
