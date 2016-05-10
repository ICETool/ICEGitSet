//
//  ICESplitController.h
//  ICEGitSet
//
//  Created by WLY on 16/5/10.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ICESplitChiledsBaseVC;
@interface ICESplitController : UIViewController

/**
 *  主视图控制器
 */
@property (nonatomic, strong, readonly) ICESplitChiledsBaseVC *masterViewController;
/**
 *  详情视图控制器 (可切换)
 */
@property (nonatomic, strong, readonly) ICESplitChiledsBaseVC *detailViewController;

/**
 *  主视图的显示界面宽度 默认 300
 */
@property (nonatomic, assign) CGFloat  masterViewWidth;

/**
 *  主视图 与 详情视图之间的间距 默认 为 15;
 */
@property (nonatomic, assign) CGFloat  lineSapcing;

/**
 *  视图控制器容器的创建
 *
 *  @param masterViewController 主视图控制器
 *  @param detailViewController 子视图控制器
 *
 *  @return 视图控制器容器
 */
- (instancetype)initWithMasterViewController:(ICESplitChiledsBaseVC *)masterViewController
                    withDetailViewController:(ICESplitChiledsBaseVC *)detailViewController;



/**
 *  切换详情视图控制器
 *
 *  @param toViewController 要显示的详情视图控制器
 *  @param animation        是否需要动画
 */
- (void)transitionDetaiViewControllerToViewController:(ICESplitChiledsBaseVC *)toViewController
                     withAnimation:(BOOL)animation;

@end
