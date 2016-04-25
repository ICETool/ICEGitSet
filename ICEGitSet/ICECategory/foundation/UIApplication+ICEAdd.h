//
//  UIApplication+GMXAdd.h
//  GMXAFNetworkTool
//
//  Created by WLY on 16/3/15.
//  Copyright © 2016年 WLY. All rights reserved.
//
/*
 * debug log
 * 系统版本
 * 设备类型
 * 设备版本
 * 沙河文件
 * 屏幕尺寸
 * 屏幕分辨路
 * 控件高度
 */

#import <UIKit/UIKit.h>



typedef void(^FirstLaunchBLock) (BOOL isFirst);

@interface UIApplication (ICEAdd)
NS_ASSUME_NONNULL_BEGIN

#pragma mark - debug log

#ifdef DEBUG
#   define DLog(...) NSLog((@"%s [Line %d] %@"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#   define SLog(...) NSLog(__VA_ARGS__)
#else
#   define DLog(...)
#   define SLog(...)
#endif



#pragma mark - ios系统版本
#define ios9x [[[UIDevice currentDevice] systemVersion] floatValue] >=9.0f
#define ios8x [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f
#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f
#define iosNot6x [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f


#pragma mark - iOS 设备类型
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#pragma mark - iOS 设备版本
#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)


#pragma mark - 沙盒文件
//文件目录
#define kPathTemp                   NSTemporaryDirectory()
#define kPathDocument               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kPathCache                  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kPathSearch                 [kPathDocument stringByAppendingPathComponent:@"Search.plist"]

#define kPathMagazine               [kPathDocument stringByAppendingPathComponent:@"Magazine"]
#define kPathDownloadedMgzs         [kPathMagazine stringByAppendingPathComponent:@"DownloadedMgz.plist"]
#define kPathDownloadURLs           [kPathMagazine stringByAppendingPathComponent:@"DownloadURLs.plist"]
#define kPathOperation              [kPathMagazine stringByAppendingPathComponent:@"Operation.plist"]

#define kPathSplashScreen           [kPathCache stringByAppendingPathComponent:@"splashScreen"]

#pragma mark - 屏幕尺寸
/**
 *  屏幕 rect
 */
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//对照屏幕比例

#define MINIMAL_UI (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

#pragma mark - 屏幕分辨率
/**
 *  屏幕分辨率
 */
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

#pragma mark - 控件高度
/* 控件高度 */
#define NAVIGATION_BAR_HEIGHT               (MINIMAL_UI ? 64.0f : 44.0f)
#define STATUS_BAR_HEIGHT                                         20    // 状态栏
#define TABBAR_HEIGHT                                             50    //标签栏


/// "Documents" folder in this app's sandbox.

@property (nonatomic, readonly) NSURL *documentsURL;
@property (nonatomic, readonly) NSString *documentsPath;
/// "Caches" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *cachesURL;
@property (nonatomic, readonly) NSString *cachesPath;
/// "Library" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *libraryURL;
@property (nonatomic, readonly) NSString *libraryPath;
//app diaplay name
@property (nonatomic, readonly) NSString *appName;
/// Application's Bundle Name (show in SpringBoard).
@property (nullable, nonatomic, readonly) NSString *appBundleName;
/// Application's Bundle ID.  e.g. "com.ibireme.MyApp"
@property (nullable, nonatomic, readonly) NSString *appBundleID;
/// Application's Version.  e.g. "1.2.0"
@property (nullable, nonatomic, readonly) NSString *appVersion;
/// Application's Build number. e.g. "123"
@property (nullable, nonatomic, readonly) NSString *appBuildVersion;
/// Whether this app is being debugged (debugger attached).
@property (nonatomic, readonly) BOOL isBeingDebugged;


/**
 *  是否是第一次启动, 启动后并设置
 *
 */
+ (void)isFirstLaunch:(FirstLaunchBLock)completion;

//收起键盘
+ (void)retractKeyBoard;

@end

NS_ASSUME_NONNULL_END