//
//  ICESplitChiledsBaseVC.h
//  ICEGitSet
//
//  Created by WLY on 16/5/10.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
 *  splitChildes视图控制器容器管理的子视图控制器的 基类 不可实例化
 */
#import <UIKit/UIKit.h>
#import "ICESplitController.h"

@interface ICESplitChiledsBaseVC : UIViewController

@property (nonatomic, weak, readonly) ICESplitController *splitController;

@end
