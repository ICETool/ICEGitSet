//
//  NSDate+ICEAdd.m
//  ICECategory_p
//
//  Created by WLY on 16/3/31.
//  Copyright © 2016年 GMX. All rights reserved.
//

#import "NSDate+ICEAdd.h"

@implementation NSDate (ICEAdd)

+ (NSString *)computeTimeSpan:(NSString *)timeString withFromatterStr:(NSString *)formatter{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:formatter];
    
    NSDate *datenow = [NSDate date];
    
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    
    
    //创建了两个日期对象
    NSDate *newDate=[dateFormatter dateFromString:timeString];
    
    NSTimeInterval time= [datenow timeIntervalSinceDate:newDate];
    NSInteger dd = (int)time;
    NSString *time_TString = [NSString string];
    
    if (dd / 3600 < 1) {
        time_TString = [NSString stringWithFormat:@"%ld",dd/60];
        time_TString = [NSString stringWithFormat:@"%@分钟前",time_TString];
    }else if (dd / 3600 > 1 && dd / 86400 < 1){
        
        time_TString = [NSString stringWithFormat:@"%ld",dd/3600];
        time_TString = [NSString stringWithFormat:@"%@小时前",time_TString];
    }else if (dd / 86400 > 1){
        
        if (dd / 86400 < 30) {
            time_TString = [NSString stringWithFormat:@"%ld",dd/86400];
            time_TString = [NSString stringWithFormat:@"%@天前",time_TString];
        }else{
            time_TString = [NSString stringWithFormat:@"%ld",dd/86400 / 30];
            time_TString = [NSString stringWithFormat:@"%@个月前",time_TString];
            if (dd / 86400 / 365 > 1) {
                time_TString = [NSString stringWithFormat:@"%ld",dd/86400 / 365];
                time_TString = [NSString stringWithFormat:@"%@年前",time_TString];
            }
        }
    }
    
    return time_TString;
    
}


@end
