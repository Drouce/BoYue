//
//  SumAbilityViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "SumAbilityViewController.h"
#import "SumAblityViewModel.h"
#import "ZBCategoryItemViewController.h"
#import "SumabilityDetailViewController.h"

@interface SumAbilityViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) SumAblityViewModel *sumVM;

@end

@implementation SumAbilityViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"召唤师技能列表";
        [Factory addBackItemToVC:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectView.header beginRefreshing];
}


- (SumAblityViewModel *)sumVM {
	if(_sumVM == nil) {
		_sumVM = [[SumAblityViewModel alloc] init];
	}
	return _sumVM;
}

- (UICollectionView *)collectView {
    if(_collectView == nil) {
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        [self.view addSubview:_collectView];
        _collectView.backgroundColor = [UIColor whiteColor];
        [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        _collectView.delegate = self;
        _collectView.dataSource = self;
        
        _collectView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self.sumVM getDataFromNetCompleteHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                } else {
                    [_collectView reloadData];
                }
                
                [_collectView.header endRefreshing];
            }];
            
        }];
        
        [_collectView registerClass:[ZBItemCell class] forCellWithReuseIdentifier:@"zbItemCell"];
        
    }
    return _collectView;
}



#pragma mark - collection的协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sumVM.rowNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZBItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zbItemCell" forIndexPath:indexPath];
    [cell.iconView.imageView setImageWithURL:[self.sumVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    cell.nameLb.text = [self.sumVM titleForRow:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SumabilityDetailViewController *sumDetailVC = [[SumabilityDetailViewController alloc]initWithSumAbilityModel:[self.sumVM modelForRow:indexPath.row]];
    [self.navigationController pushViewController:sumDetailVC animated:YES];
}

/**
 *  section上下左右的边距
 */

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 20, 5, 20);
}

//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

//计算宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = (kWindowW - 5 *20)/4;
    CGFloat h = w +17;
    return CGSizeMake(w, h);
}


@end
