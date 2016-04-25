//
//  NSDate+ICEAdd.h
//  ICECategory_p
//
//  Created by WLY on 16/3/31.
//  Copyright © 2016年 GMX. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSDate (ICEAdd)



/**
 *  计算时间差
 */
+ (NSString *)computeTimeSpan:(NSString *)timeString withFromatterStr:(NSString *)formatter;

@end
