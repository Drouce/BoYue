//
//  TTuWanListViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TTuWanListViewController.h"
#import "TuWanListCell.h"
#import "TuWanViewModel.h"
#import "TuWanImageCell.h"
#import "iCarousel.h"
#import "TuWanHtmlViewController.h"

@interface TTuWanListViewController ()<iCarouselDataSource,iCarouselDelegate>

@property (nonatomic, strong)TuWanViewModel *TuWanVm;
@end

@implementation TTuWanListViewController
{
    //添加成员变量，不需要懒加载，
    iCarousel *_ic;
    UIPageControl *_pageControl;
    UILabel *_titleLb;
    NSTimer *_timer;
}

/**
 *  头部视图，oringin无效，宽度无效，坑定是与table同宽
 */
- (UIView *)headerView {
    
    [_timer invalidate];
    
    //如果当前没有滚动视图,返回nil
    if (!self.TuWanVm.isExitIndexPic) {
        return nil;
    }
    UIView *heaadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, kWindowW/750 *500)];
    
    //添加底部视图
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = kRGBColor(250, 250, 250);
    [heaadView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    
    //_titleLb设置
    _titleLb = [UILabel new];
    [bottomView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    _titleLb.text = [self.TuWanVm titleForRowIndexPic:0];
    
    //_pageControl设置
    _pageControl  = [UIPageControl new];
    _pageControl.numberOfPages = self.TuWanVm.indexPicNumber;
    [bottomView addSubview: _pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(60);
        make.width.mas_greaterThanOrEqualTo(20);
        make.left.mas_equalTo(_titleLb.mas_right).mas_equalTo(10);
    }];
    
    //添加滚动栏
    _ic = [iCarousel new];
    [heaadView addSubview: _ic];
    [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomView.mas_top).mas_equalTo(0);
    }];
    _ic.delegate = self;
    _ic.dataSource = self;
    _ic.pagingEnabled = YES;
    _ic.scrollSpeed = 1;
    
    //如果只有一张图,则不显示圆点
    _pageControl.hidesForSinglePage = YES;
    //如果只有一张图,则不可以滚动
    _ic.scrollEnabled = self.TuWanVm.indexPicNumber !=1;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor greenSeaColor];
    //小圆点不允许交互
    _pageControl.userInteractionEnabled = NO;
    
    if (self.TuWanVm.indexPicNumber > 1) {
        _timer = [NSTimer bk_scheduledTimerWithTimeInterval:2 block:^(NSTimer *timer) {
            [_ic scrollToItemAtIndex:_ic.currentItemIndex +1 animated:YES];
        } repeats:YES];
    }
    return heaadView;
}

#pragma mark - 实现iCarousel协议方法
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.TuWanVm.indexPicNumber;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (!view) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW/750 *500 -35)];
        
        UIImageView *imageViw = [UIImageView new];
        [view addSubview:imageViw];
        imageViw.tag = 100;
        imageViw.contentMode = 2;
        view.clipsToBounds = YES;
        [imageViw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    
    UIImageView *imageView = (UIImageView *)[view viewWithTag:100];
    
    [imageView setImageWithURL:[self.TuWanVm iconURLForRowIndexPic:index] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    return view;
}

/**
 *  允许循环滚动
 */

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}

/**
 *  监听滚动到第几个
 */

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    //DDLogVerbose(@"%@",carousel);
    
    _titleLb.text = [self.TuWanVm titleForRowIndexPic:carousel.currentItemIndex];
    _pageControl.currentPage = carousel.currentItemIndex;
}


/** 懒加载 */
-(TuWanViewModel *)TuWanVm {
    if (!_TuWanVm) {
        _TuWanVm = [[TuWanViewModel alloc]initWithType:_TuWanListType.integerValue];
    }
    return _TuWanVm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[TuWanListCell class] forCellReuseIdentifier:@"ListCell"];
    [self.tableView registerClass:[TuWanImageCell class] forCellReuseIdentifier:@"ImageCell"];
    
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.TuWanVm refreshDataCompletionHandle:^(NSError *error) {
            self.tableView.tableHeaderView = [self headerView];
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
        }];
        
        
    }];
    
    //加载更多数据
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.TuWanVm getMoreDataCompletionHandle:^(NSError *error) {
            self.tableView.tableHeaderView = [self headerView];
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];
        }];
    }];
    
    [self.tableView.header beginRefreshing];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return  self.TuWanVm.rowNumber;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.TuWanVm ContainImages:indexPath.row]) {
        TuWanImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
        
        cell.titleLb.text = [self.TuWanVm titleForRowInList:indexPath.row];
        cell.clicksNumLb.text = [[self.TuWanVm clickForRowInList:indexPath.row]stringByAppendingString:@"浏览"];
        
        [cell.iconIV0.imageView setImageWithURL:[self.TuWanVm iconURLSForRowInList:indexPath.row][0] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
        
        [cell .iconIV1.imageView setImageWithURL:[self.TuWanVm iconURLSForRowInList:indexPath.row][1] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
        
        [cell .iconIV2.imageView setImageWithURL:[self.TuWanVm iconURLSForRowInList:indexPath.row][2] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
        return cell;
        
    }
    
    TuWanListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell" forIndexPath:indexPath];
    [cell.iconIV.imageView setImageWithURL:[self.TuWanVm iconURLForRowInList:indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_5"]];
    cell.titleLb.text = [self.TuWanVm titleForRowInList:indexPath.row];
    cell.longTitleLb.text = [self.TuWanVm descForRowInList:indexPath.row];
    cell.clicksNumLb.text = [[self.TuWanVm clickForRowInList:indexPath.row]stringByAppendingString:@"浏览"];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.TuWanVm ContainImages:indexPath.row]? 135 : 90;
}

/** 去分割线 */
kRemoveCellSeparator

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.TuWanVm isHtmlInListForRow:indexPath.row]) {
        TuWanHtmlViewController *htmlVc = [[TuWanHtmlViewController alloc]initWithURL:[self.TuWanVm detailURLForRowInList:indexPath.row]];
        
        [self.navigationController pushViewController:htmlVc animated:YES];
    }
}


/**
 *  滚动栏中被选中后触发
 */

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    if ([self.TuWanVm isHtmlInIndexPicForRow:index]) {
        TuWanHtmlViewController *htmlVc = [[TuWanHtmlViewController alloc]initWithURL:[self.TuWanVm detailURLForRowIndexPic:index]];
        
        [self.navigationController pushViewController:htmlVc animated:YES];
    }
}

@end
