//
//  ICEKeyboardNotifaction.h
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ICEKeyboardNotifaction;
@protocol KeyBoardDlegate <NSObject>

- (void)keyboardWillShowNotification:(NSNotification *)notification;
- (void)keyboardWillHideNotification:(NSNotification *)notification;

@end

@interface ICEKeyboardNotifaction : NSObject


/**
 *  注册键盘出现
 *
 *  @param target 目标(self)
 */
+ (void)registerKeyBoardShow:(id)target;
/**
 *  注册键盘隐藏
 *
 *  @param target 目标(self)
 */
+ (void)registerKeyBoardHide:(id)target;

/**
 *  移除添加通知
 */
+ (void)removekeyBoardShow:(id)target;

/**
 *  移除隐藏通知
 */
+ (void)removeKeyBoardHide:(id)target;

/**
 *
 *
 *  @return 返回键盘，包括高度、宽度
 */
+ (CGRect)returnKeyBoardWindow:(NSNotification *)notification;
/**
 *
 *
 *  @return 返回键盘上拉动画持续时间
 */
+ (double)returnKeyBoardDuration:(NSNotification *)notification;
/**
 *
 *
 *  @return 返回键盘上拉，下拉动画曲线
 */
+ (UIViewAnimationCurve)returnKeyBoardAnimationCurve:(NSNotification *)notification;



@end
