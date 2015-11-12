//
//  BestGroupDetailViewController.h
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BestGroupDetailViewController : UIViewController

- (instancetype)initWithTitle:(NSString *)titleLb desc:(NSString *)desc icons:(NSArray *)icons decscs:(NSArray *)descs;

@property (nonatomic, strong) NSString *titleLb;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSArray *icons;
@property (nonatomic, strong) NSArray *descs;
@end
