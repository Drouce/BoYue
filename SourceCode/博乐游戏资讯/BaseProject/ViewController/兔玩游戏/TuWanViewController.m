//
//  TuWanViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/5.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanViewController.h"
#import "TuWanViewModel.h"
#import "TTuWanListViewController.h"

@interface TuWanViewController ()

@end

@implementation TuWanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenSeaColor];
    self.title = @"豆味玩";
    
    [Factory addMenuItemToVC:self];
}


+(UINavigationController *)standarTuWanNavi {
    static UINavigationController *navi = nil;
    static dispatch_once_t onceToken;
   
    dispatch_once(&onceToken, ^{
        TuWanViewController *tuWanVc = [[TuWanViewController alloc]initWithViewControllerClasses:[self viewControllerClasses] andTheirTitles:[self itemNames]];
        
        //设置控制器的方法，KVC
        // vc setValue:values[0] forKey:keys[0]
        tuWanVc.keys = [self vcKeys];
        tuWanVc.values = [self vcValues];
        navi = [[UINavigationController alloc]initWithRootViewController:tuWanVc];
    });
    return navi;
}


+ (NSArray *)vcValues {
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < [self itemNames].count; i ++) {
        //数值，VC的typeInfo枚举值恰好和i相同
        [arr addObject:@(i)];
    }
    return arr;
}

+ (NSArray *)vcKeys {
    NSMutableArray *arr = [NSMutableArray new];
    for (id obj in [self itemNames]) {
        [arr addObject:@"TuWanListType"];
    }
    return [arr copy];

}

/**
 *  提供题目数组
 */
+ (NSArray *)itemNames {
    return @[@"头条",@"独家",@"暗黑3",@"魔兽",@"风暴",@"炉石",@"星际2",@"守望",@"图片",
             @"视频",@"攻略",@"幻化",@"趣闻",@"COS",@"美女"];
}

/**
 *  提供每个题目对应的控制器的类型，题目和类型数量逆序一致
 */

+ (NSArray *)viewControllerClasses {
    
    NSMutableArray *arr = [NSMutableArray new];
    for (id obj in [self itemNames]) {
        [arr addObject:[TTuWanListViewController class]];
    }
    return [arr copy];
}

@end
