//
//  ZBCategoryViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ZBCategoryViewController.h"
#import "ZBCategoryViewModel.h"
#import "ZBCategoryItemViewController.h"

@interface ZBCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZBCategoryViewModel *zbVM;
@end

@implementation ZBCategoryViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"装备分类";
        [Factory addBackItemToVC:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView.header beginRefreshing];
}

-(ZBCategoryViewModel *)zbVM {
    if (!_zbVM) {
        _zbVM = [[ZBCategoryViewModel alloc]init];
    }
    return _zbVM;
}

- (UITableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.zbVM getDataFromNetCompleteHandle:^(NSError *error) {
                
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
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
	}
	return _tableView;
}

#pragma mark - UITableView协议

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.zbVM.rownNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.zbVM textForRow:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZBCategoryItemViewController *zbItemVC = [[ZBCategoryItemViewController alloc]initWithTag:[self.zbVM tagForRow:indexPath.row]  name:[self.zbVM textForRow:indexPath.row]];
    [self.navigationController pushViewController:zbItemVC animated:YES];
}

@end
