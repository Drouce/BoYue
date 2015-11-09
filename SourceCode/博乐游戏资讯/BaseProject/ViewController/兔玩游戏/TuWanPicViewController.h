//
//  TuWanPicViewController.h
//  BaseProject
//
//  Created by drouce on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuWanPicViewController : UIViewController
/** 此界面根据aid来决定 */
- (id)initWithAid:(NSString *)aid;
@property (nonatomic, strong) NSString * aid;

@end
