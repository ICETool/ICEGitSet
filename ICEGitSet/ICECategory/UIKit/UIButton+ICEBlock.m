//
//  UIButton+ICEBlock.m
//  Wanliyun
//
//  Created by WLY on 16/3/21.
//  Copyright © 2016年 wlycloud. All rights reserved.
//

#import "UIButton+ICEBlock.h"
#import "UIControl+ICEBlock.h"
#import <objc/runtime.h>




@implementation UIButton (ICEBlock)

static char overviewKey;

@dynamic event;

- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}


- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block(sender);
        
    }
}

@end
