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
@synthesize myItems = _myItems;


- (NSArray *)myItems{

    if (!_myItems) {
        _myItems = [NSArray array];
    }
    return _myItems;
}

- (void)setMyItems:(NSArray *)myItems{

    if (_myItems != myItems) {
        _myItems = myItems;
        [self p_reloadBtnItem];
    }
}

- (void)setCurrentSelectedindex:(NSInteger)currentSelectedindex{
    if (_currentSelectedindex != currentSelectedindex) {
        _currentSelectedindex  = currentSelectedindex;
        for (int j = 0 ; j < self.myItems.count; j ++) {
            ICETabbarButtonItem *otherItme = [self viewWithTag:1000 + j];
            otherItme.selected = NO;
        }
        ICETabbarButtonItem *item = [self viewWithTag:1000 + _currentSelectedindex];
        item.selected = YES;
    }
}


#pragma mark - reload subviews
- (void)p_reloadBtnItem{

    
    if (self.myItems.count == 2) {
        [self p_reloadIteamForIpad_twoIteam];
        return;
    }
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    self.currentSelectedindex = -1;
    NSInteger count = self.myItems.count;
    CGFloat item_w = CGRectGetWidth(self.bounds) / count;
    CGFloat item_h = CGRectGetHeight(self.bounds);
    CGFloat item_x = 0;
    for (int i = 0 ; i < count ; i ++) {
        
        CGRect frame = CGRectMake(item_x, 0, item_w, item_h);
        
        ICETabbarButtonItem *item = self.myItems[i];
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


/**
 *  当只有两个iteam时的布局
 */
- (void)p_reloadIteamForIpad_twoIteam{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    self.currentSelectedindex = -1;
    NSInteger count = self.myItems.count;
    CGFloat item_w = CGRectGetWidth(self.bounds) / (count * 2);
    CGFloat item_h = CGRectGetHeight(self.bounds);
    CGFloat item_x = item_w;
    for (int i = 0 ; i < count ; i ++) {
        
        CGRect frame = CGRectMake(item_x, 0, item_w, item_h);
        
        ICETabbarButtonItem *item = self.myItems[i];
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
        item_x += item_w ;
    }
    
    if (count > 0) {
        self.currentSelectedindex = 0;
    }

}


- (void)didSelectedItem:(SelectedItemBlock)compeltion{
    _selectedBlock = compeltion;
}


- (void)didMoveToSuperview{

    [super didMoveToSuperview];
    [self p_reloadBtnItem];
}
@end
