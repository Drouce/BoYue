//
//  RankListViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/5.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "RankListViewController.h"
#import "XiMaCategoryCell.h"
#import "XiMaCategoryViewModel.h"

@interface RankListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) XiMaCategoryViewModel *ximaVM;
@end

@implementation RankListViewController


- (XiMaCategoryViewModel *)ximaVM {
    if(_ximaVM == nil) {
        _ximaVM = [[XiMaCategoryViewModel alloc] init];
    }
    return _ximaVM;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[XiMaCategoryCell class] forCellReuseIdentifier:@"ximaCell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}

+ (UINavigationController *)defaultNavi; {
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        RankListViewController *vc = [RankListViewController new];
        navi = [[UINavigationController alloc]initWithRootViewController:vc];
    });
    return navi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Factory addMenuItemToVC:self];
    self.title = @"博乐Music";
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.ximaVM refreshDataCompletionHandle:^(NSError *error) {
            if (error) {
                [self showErrorMsg:error.localizedDescription];
                
            } else {
                [self.tableView reloadData];
            }
            //重置脚步，没有更多数据
            [_tableView.footer resetNoMoreData];
            [_tableView.header endRefreshing];
        }];
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.ximaVM getMoreDataCompletionHandle:^(NSError *error) {
            if (error) {
                [self showErrorMsg:error.localizedDescription];
                
                if (error.code == 999) {
                    [self.tableView.footer endRefreshingWithNoMoreData];
                }else {
                    [_tableView.footer endRefreshing];
                }

            }else {
                [self.tableView reloadData];
            }
            [_tableView.footer endRefreshing];
        }];
    }];
    
    [self.tableView.header beginRefreshing];
}


#pragma mark - UItableView协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ximaVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XiMaCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ximaCell"];
    cell.titleLb.text = [self.ximaVM titleForRow:indexPath.row];
    cell.descLb.text = [self.ximaVM descForRow:indexPath.row];
    cell.numberLb.text = [self.ximaVM numberForRow:indexPath.row];
    [cell.iconIV.imageView setImageWithURL:[self.ximaVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    cell.orderLb.text = @(indexPath.row +1).stringValue;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}


@end
