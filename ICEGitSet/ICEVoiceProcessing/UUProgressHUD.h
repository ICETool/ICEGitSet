//
//  UUProgressHUD.h
//  1111
//
//  Created by shake on 14-8-6.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  animation_duration 0.1;//动画时间

@interface UUProgressHUD : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

+ (UUProgressHUD*)sharedView;

+ (void)show;

+ (void)dismissWithSuccess:(NSString *)str;

+ (void)dismissWithError:(NSString *)str;

+ (void)changeSubTitle:(NSString *)str;

@end
