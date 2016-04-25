//
//  ICEDrawerViewController.h
//  ICEDrawerViewController
//
//  Created by WLY on 16/4/21.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
 *  视图管理器容器
 */

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#import <UIKit/UIKit.h>

@interface ICEDrawerController : UIViewController
@property (nonatomic, strong) UIImageView *backgroundImageView;//背景视图

/**
 *  初始化方法, 其中左侧或者右侧视图均不能为空
 *
 *  @param leftVC  左侧抽屉
 *  @param rightVC 右侧抽屉
 *
 */
- (instancetype)initDrawerViewControllerWithMainVC:(UIViewController *)mainVC
                                       andLeftVC:(UIViewController *)leftVC
                                      andRightVC:(UIViewController *)rightVC;



/**
 *  设置是否开启左右滑动 打开抽屉
 */
- (void)setPanEnable:(BOOL)enable;



/**
 *  打开做左视图
 */
- (void)openLeftVC;
/**
 *  关闭左视图
 */
- (void)closeLeftVC;
/**
 *  打开右视图
 */
- (void)openRightVC;
/**
 *  关闭右视图
 */
- (void)closeRightVC;
@end
