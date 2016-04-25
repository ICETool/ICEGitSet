//
//  NSObject+GMXAdd.h
//  GMXAFNetworkTool
//
//  Created by WLY on 16/3/15.
//  Copyright © 2016年 WLY. All rights reserved.
//
/*
 * 关联
 * 获取类名
 * 获取当前视图控制器
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN




@interface NSObject (ICEAdd)
#pragma mark - Associate value
///=============================================================================
/// @name Associate value
///=============================================================================

/**
 Associate one object to `self`, as if it was a strong property (strong, nonatomic).
 
 @param value   The object to associate.
 @param key     The pointer to get value from `self`.
 */
- (void)setAssociateValue:(nullable id)value withKey:(void *)key;

/**
 Associate one object to `self`, as if it was a weak property (week, nonatomic).
 
 @param value  The object to associate.
 @param key    The pointer to get value from `self`.
 */
- (void)setAssociateWeakValue:(nullable id)value withKey:(void *)key;

/**
 Get the associated value from `self`.
 
 @param key The pointer to get value from `self`.
 */
- (nullable id)getAssociatedValueForKey:(void *)key;

/**
 Remove all associated values.
 */
- (void)removeAssociatedValues;
#pragma mark - Others
///=============================================================================
/// @name Others
///=============================================================================

/**
 Returns the class name in NSString.
 */
+ (NSString *)className;

/**
 Returns the class name in NSString.
 
 @discussion Apple has implemented this method in NSObject(NSLayoutConstraintCallsThis),
 but did not make it public.
 */
- (NSString *)className;


/**
 *  获取当前显示的视图控制器
 */
+ (UIViewController *)getCurrentVC;



@end

NS_ASSUME_NONNULL_END