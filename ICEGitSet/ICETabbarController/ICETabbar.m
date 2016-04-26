//
//  GMXTabbarView.m
//  GMXTabbarController
//
//  Created by WLY on 16/2/7.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ICETabbar.h"

@interface ICETabbar ()

@property (nonatomic, copy) SelectedItemBlock selectedBlock;
@property (nonatomic, assign) NSInteger currentSelectedindex;
@end

@implementation ICETabbar
@synthesize items = _items;

- (NSArray *)_items{
    
    if (!_items) {
        _items = [NSArray array];
        
    }
    return _items;
}

- (void)setItems:(NSArray *)items{
    if (_items != items) {
        _items = items;
        [self p_reloadBtnItem];
    }

}
- (void)setCurrentSelectedindex:(NSInteger)currentSelectedindex{
    if (_currentSelectedindex != currentSelectedindex) {
        _currentSelectedindex  = currentSelectedindex;
        for (int j = 0 ; j < self.items.count; j ++) {
            ICETabbarButtonItem *otherItme = [self viewWithTag:1000 + j];
            otherItme.selected = NO;
        }
        ICETabbarButtonItem *item = [self viewWithTag:1000 + _currentSelectedindex];
        item.selected = YES;
    }
}


#pragma mark - reload subviews
- (void)p_reloadBtnItem{

    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    self.currentSelectedindex = -1;
    NSInteger count = self.items.count;
    CGFloat item_w = CGRectGetWidth(self.bounds) / count;
    CGFloat item_h = CGRectGetHeight(self.bounds);
    CGFloat item_x = 0;
    for (int i = 0 ; i < count ; i ++) {
        
        CGRect frame = CGRectMake(item_x, 0, item_w, item_h);
        
        ICETabbarButtonItem *item = self.items[i];
        item.tag = 1000 + i;;
        item.frame = frame;
        item.backgroundColor = [UIColor greenColor];
        [item whenTouchedUp:^{

            if (self.selectedBlock) {
                self.selectedBlock(i);
            }
           self.currentSelectedindex = i;
        }];

        item.backgroundColor = [UIColor clearColor];
        [self addSubview:item];
        item_x += item_w;
    }

    if (count > 0) {
        self.currentSelectedindex = 0;
    }
}


- (void)didSelectedItem:(SelectedItemBlock)compeltion{
    _selectedBlock = compeltion;
}
@end
