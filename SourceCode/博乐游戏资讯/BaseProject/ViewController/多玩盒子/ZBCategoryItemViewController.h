//
//  ZBCategoryItemViewController.h
//  BaseProject
//
//  Created by drouce on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRImageView.h"

@interface ZBCategoryItemViewController : UIViewController

- (id)initWithTag:(NSString *)tag name:(NSString *)name;
//@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tag;
@end


@interface ZBItemCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) DRImageView *iconView;


@end
