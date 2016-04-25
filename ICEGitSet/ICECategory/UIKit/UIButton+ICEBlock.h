//
//  UIButton+ICEBlock.h
//  Wanliyun
//
//  Created by WLY on 16/3/21.
//  Copyright © 2016年 wlycloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock) (UIButton *button);


@interface UIButton (ICEBlock)
@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;
@end
