//
//  DuoWanBarController.m
//  BaseProject
//
//  Created by drouce on 15/11/5.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DuoWanBarController.h"
#import "HeroViewController.h"
#import "BaiKeViewController.h"
#import "SearchViewController.h"

@interface DuoWanBarController ()

@end

@implementation DuoWanBarController

+ (DuoWanBarController *)standardInstance {
    static DuoWanBarController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        vc = [DuoWanBarController new];
    });
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //取消工具栏的透明状态
    self.tabBar.translucent = NO;
    //self.tabBar.hidden = YES;
    
    //初始化三个子视图
    HeroViewController *heroVC = [HeroViewController new];
    SearchViewController *searchVC = [SearchViewController new];
    BaiKeViewController *baiKeVC = [BaiKeViewController new];
    
    UINavigationController *heroNavi = [[UINavigationController alloc]initWithRootViewController:heroVC];
    
    UINavigationController *searchNavi = [[UINavigationController alloc]initWithRootViewController:searchVC];
    
    UINavigationController *baikeNavi = [[UINavigationController alloc]initWithRootViewController:baiKeVC];
    
    self.viewControllers = @[heroNavi,searchNavi,baikeNavi];
    
}





@end
