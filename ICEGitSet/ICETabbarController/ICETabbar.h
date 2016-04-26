//
//  GMXTabbarView.h
//  GMXTabbarController
//
//  Created by WLY on 16/2/7.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICETabbarButtonItem.h"

typedef void (^SelectedItemBlock) (NSInteger index);

@interface ICETabbar : UIView 
@property (nonatomic, strong) NSArray *items;

/**
 *  选中回调
 */
- (void)didSelectedItem:(SelectedItemBlock)compeltion;


@end
