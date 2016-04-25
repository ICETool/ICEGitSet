//
//  NSObject+GMXAdd.m
//  GMXAFNetworkTool
//
//  Created by WLY on 16/3/15.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "NSObject+ICEAdd.h"
#import <objc/runtime.h>


@implementation NSObject (ICEAdd)

#pragma mark - 关联

- (void)setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAssociateWeakValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (void)removeAssociatedValues {
    objc_removeAssociatedObjects(self);
}

- (id)getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

#pragma mark - 获取类名

+ (NSString *)className {
    return NSStringFromClass(self);
}

- (NSString *)className {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

#pragma mark - 获取当前的显示的视图控制器

+ (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    //获取当前的跟视图控制器
    result = [NSObject visableViewController:result];
    
    
    
    return result;
}


/* 获取当前跟视图控制器所显示的最上层的视图控制器 */
+ (UIViewController *)visableViewController:(UIViewController *)VC{
    if ([VC isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController *)VC visibleViewController];
    }else if ([VC isKindOfClass:[UITabBarController class]]) {
        UIViewController *currentVC = [(UITabBarController *)VC selectedViewController];
        return [NSObject visableViewController:currentVC];
    }else if ([VC isKindOfClass:[UIViewController class]]){
        
        return VC;
    }
    return nil;
}


@end
