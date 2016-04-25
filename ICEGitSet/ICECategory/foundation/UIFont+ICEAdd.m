//
//  UIFont+Extend.m
//  Wifi
//
//  Created by muxi on 14/12/1.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import "UIFont+ICEAdd.h"
#import "UIApplication+ICEAdd.h"




@implementation UIFont (ICEAdd)


#pragma mark  打印并显示所有字体
+(void)showAllFonts{
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
}




#pragma mark  宋体
+(UIFont *)songTypefaceFontOfSize:(CGFloat)size{
    
    return [UIFont fontWithName:@"经典宋体简" size:size];
    
}





#pragma mark  微软雅黑
+(UIFont *)microsoftYaHeiFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"MicrosoftYaHei" size:size];
}




#pragma mark  微软雅黑：加粗字体
+(UIFont *)boldMicrosoftYaHeiFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"MicrosoftYaHei-Bold" size:size];
}




#pragma mark  DroidSansFallback
+(UIFont *)customFontNamedDroidSansFallbackWithFontOfSize:(CGFloat)size{
    return [UIFont fontWithName:@"DroidSansFallback" size:size];
}




#pragma mark - 常用字体
+ (UIFont *)fontWithSize:(CGFloat)size{

    size *= [UIFont fontRatio];
    return [UIFont systemFontOfSize:size];
}

+ (UIFont *)boldFontWithSize:(CGFloat)size{

    size *= [UIFont fontRatio];
    return [UIFont boldFontWithSize:size];
}

+ (CGFloat)fontRatio{

    CGFloat ratio = 1;
    if (iphone6Plus_5_5) {
        ratio = 1.5;
    }else if(iphone6_4_7 || iphone4x_3_5 || iphone5x_4_0){
        ratio = 1;
    }
    return ratio;
}













@end
