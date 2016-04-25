//
//  ICEPuddDownMenuView.h
//  ICEPullDownMenu
//
//  Created by WLY on 16/4/25.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
 *  计算字体size
 *  @return size
 */
#define sizeWithString(string,w,h,Font) [(NSString *)string boundingRectWithSize:CGSizeMake(w, h) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : Font} context:nil].size


#import <UIKit/UIKit.h>

typedef void (^SelectCellBlock) (NSInteger index ,BOOL selected);


@interface ICESegmentView : UIView

@property (nonatomic, strong) UIColor *tinColor;
@property (nonatomic, strong) UIColor *selectedColor;

//更具标题数组进行初始化
- (instancetype)initWithTitles:(NSArray *)titles withFrame:(CGRect)frame;

/**
 *  为指定下标设置标题
 *
 *  @param title 标题
 *  @param index 下标 0~
 */
- (void)setTitle:(NSString *)title
        forIndex:(NSInteger)index;


/**
 *  选中回调
 */
- (void)didSelectedCell:(SelectCellBlock)completion;

/**
 *  刷新界面
 */
- (void)reloadMenuView;
@end
