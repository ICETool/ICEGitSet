//
//  NSFileManager+ICEAdd.h
//  ICECategory_p
//
//  Created by WLY on 16/3/31.
//  Copyright © 2016年 GMX. All rights reserved.
//

/**
 *  文件创建过程中, 会自动转换所给路径中的 '/' 字符
 */
#import <Foundation/Foundation.h>

@interface NSFileManager (ICEAdd)

/**
 * 创建文件夹
 */
+ (BOOL)creatFileWithPath:(NSString *)path;

/**
 *  删除文件夹
 */
+ (BOOL)removeFileWithPath:(NSString *)path;




@end
