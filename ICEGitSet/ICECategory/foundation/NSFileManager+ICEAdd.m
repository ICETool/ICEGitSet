//
//  NSFileManager+ICEAdd.m
//  ICECategory_p
//
//  Created by WLY on 16/3/31.
//  Copyright © 2016年 GMX. All rights reserved.
//

#import "NSFileManager+ICEAdd.h"

@implementation NSFileManager (ICEAdd)

+ (BOOL)creatFileWithPath:(NSString *)path{

    path = [NSFileManager p_converterPath:path];
    BOOL result = NO;
    // 判断文件夹是否存在，如果不存在，则创建
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        result = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        return  YES;
    }
    
    return result;
}


+ (BOOL)removeFileWithPath:(NSString *)path{
    BOOL result = NO;
    // 判断文件夹是否存在，如果不存在，则创建
    path = [NSFileManager p_converterPath:path];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        
        result = [fileManager removeItemAtPath:path error:NULL];
    } else {
        return  YES;
    }
    
    return result;
    
}

/* 字符串转换, 去除路径相关字符  */
+ (NSString *)p_converterPath:(NSString *)path{
    
    return [path stringByReplacingOccurrencesOfString:@"/" withString:@"ICE"];
}




@end
