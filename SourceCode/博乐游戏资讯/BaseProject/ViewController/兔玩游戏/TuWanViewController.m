//
//  TuWanViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/5.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanViewController.h"

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
        TuWanViewController *tuWanVc = [TuWanViewController new];
        navi = [[UINavigationController alloc]initWithRootViewController:tuWanVc];
    });
    return navi;
}

@end
