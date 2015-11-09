//
//  TuWanPicViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanPicViewController.h"
#import "TuWanPicViewModel.h"
@interface TuWanPicViewController ()<MWPhotoBrowserDelegate>
@property (nonatomic, strong)TuWanPicViewModel *picViewModel;
@end

@implementation TuWanPicViewController
- (TuWanPicViewModel *)picViewModel {
    if (!_picViewModel) {
        _picViewModel = [[TuWanPicViewModel alloc]initWithAid:_aid];
    }
    return _picViewModel;
}

- (id)initWithAid:(NSString *)aid {
    if (self = [super init]) {
        self.aid = aid;
    }
    return  self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert1(NO, @"%s 必须使用initWithAid初始化方法", __func__);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //修改背景色，默认你是透明；
    self.view.backgroundColor = [UIColor whiteColor];
    [Factory addBackItemToVC:self];
    [self showProgress];
    
    
    [self.picViewModel getDataFromNetCompleteHandle:^(NSError *error) {
        
        [self hideProgress];
       //创建图片展示界面,github排名最高的图片展示类
        MWPhotoBrowser *photo = [[MWPhotoBrowser alloc]initWithDelegate:self];
        
        [self.navigationController pushViewController:photo animated:YES];
        
        //图片展示页面不应该是退出来的而应该是取代当前页面在导航 控制器中的位置
        NSMutableArray *naviVCs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        //删除掉最后一个控制，即当前的白色控制器
        [naviVCs removeLastObject];
        //把图片了控制器添加到最后
        [naviVCs addObject:photo];
        //把新的控制器数组赋值给导航控制器
        self.navigationController.viewControllers = naviVCs;
    }];
    
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return  self.picViewModel.rowNumber;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index; {
    MWPhoto *mphoto = [MWPhoto photoWithURL:[self.picViewModel PicURLFowRow:index]];
    return mphoto;
}


@end
