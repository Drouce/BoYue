//
//  ZBCategoryItemViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ZBCategoryItemViewController.h"
#import "ZBItemViewModel.h"

@implementation ZBItemCell

- (UILabel *)nameLb {
    if(_nameLb == nil) {
        _nameLb = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLb];
        _nameLb.font = [UIFont systemFontOfSize:11];
        _nameLb.textAlignment = NSTextAlignmentCenter;
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
        }];
    }
    return _nameLb;
}

- (DRImageView *)iconView {
    if(_iconView == nil) {
        _iconView = [[DRImageView alloc] init];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(_iconView.mas_width);
        }];
    }
    return _iconView;
}


@end



@interface ZBCategoryItemViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) ZBItemViewModel *zbItemVM;

@end

@implementation ZBCategoryItemViewController

-(id)initWithTag:(NSString *)tag name:(NSString *)name {
    if (self = [super init]) {
        self.tag = tag;
        self.title = name;
        [Factory addBackItemToVC:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectView.header beginRefreshing];
    
    
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
           
            [self.zbItemVM getDataFromNetCompleteHandle:^(NSError *error) {
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

- (ZBItemViewModel *)zbItemVM {
	if(_zbItemVM == nil) {
		_zbItemVM = [[ZBItemViewModel alloc] initWithTag:self.tag];
	}
	return _zbItemVM;
}

#pragma mark - collection的协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.zbItemVM.rowNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZBItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zbItemCell" forIndexPath:indexPath];
    [cell.iconView.imageView setImageWithURL:[self.zbItemVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    cell.nameLb.text = [self.zbItemVM itemNameForRow:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
