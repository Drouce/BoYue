//
//  SumabilityDetailViewController.h
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SumAbilityModel.h"

@interface SumabilityDetailViewController : UIViewController

- (instancetype)initWithSumAbilityModel:(SumAbilityModel *)abilityModel;
@property (nonatomic, strong) SumAbilityModel *abilityModel;
@end
