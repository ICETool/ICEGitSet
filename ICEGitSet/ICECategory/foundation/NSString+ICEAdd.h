//
//  NSString+ICEAdd.h
//  ICE_Progect
//
//  Created by WLY on 16/3/31.
//  Copyright © 2016年 GMX. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  计算字体size
 *  @return size
 */
#define sizeWithString(string,w,h,Font) [(NSString *)string boundingRectWithSize:CGSizeMake(w, h) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : Font} context:nil].size


@interface NSString (ICEAdd)

@end
