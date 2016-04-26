//
//  GMXTabbarController.h
//  GMXTabbarController
//
//  Created by WLY on 16/2/7.
//  Copyright © 2016年 WLY. All rights reserved.
//
/* 
 * 在storyboard中使用时,需要在viewWillappler中添加item
 * 纯代码中 正常添加
 */

#import <UIKit/UIKit.h>
#import "ICETabbar.h"


@interface ICETabbarController : UITabBarController
@property (nonatomic, strong) ICETabbar *myTabbar;

@end
