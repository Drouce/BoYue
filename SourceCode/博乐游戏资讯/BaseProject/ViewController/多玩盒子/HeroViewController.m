//
//  HeroViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "HeroViewController.h"

@interface HeroViewController ()

@end

@implementation HeroViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"英雄";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Factory addMenuItemToVC:self];
    
}



@end
