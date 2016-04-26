//
//  GMXSimpleLayout.h
//  UI_Lession(UICollectionView)
//
//  Created by WLY on 16/1/25.
//  Copyright © 2016年 蓝鸥科技. All rights reserved.
//
 /**
   一种返回cell 宽度值得瀑布流
  
  */



typedef enum  SupplementaryType{
    SupplementaryTypeHeader,
    SupplementaryTypeFoot
}SupplementaryType;

#import <UIKit/UIKit.h>
@class ICESimpleLayout;

#pragma mark - cell
/**
 *  block回调获取布局对象指定单元格的size
 */
typedef CGSize (^ICECellSizeBlock) (NSIndexPath *indexPath);
/**
 *  当计算出布局对象某一分区高度后的回调,
 */
typedef void (^ICESectionHeightBlock) (NSInteger section,CGFloat height);


#pragma mark - header && foot
/**
 *  为指定分区返回区头,(区头与单元格视图间距为0);
 */
typedef UIView * (^ICESupplementaryViewBlock) (NSInteger section,SupplementaryType type);

/**
 *  返回区头或者区尾的高度
 */
typedef CGSize (^ICESupplementaryViewSizeBlock) (NSInteger section,SupplementaryType type);


@interface ICESimpleLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat interItemSpacing; //单元格之间列
@property (nonatomic, assign) CGFloat lineItemSpacing; //行间距
@property (nonatomic, assign) UIEdgeInsets sectionInset;//设置内边距

/**
 *  为布局对象返回单元格size
 */
- (void)returnCellSize:(ICECellSizeBlock)cellSize;

/**
 *  获取分区高度
 */
- (void)getSectionHeight:(ICESectionHeightBlock)sectionHeight;


/**
 *  返回辅助视图(区头,区尾)
 */
- (void)returnSupplementaryView:(ICESupplementaryViewBlock)supplementView;
/**
 *  返回辅助视图size(区头,区尾)
 */
- (void)returnSupplementaryViewSize:(ICESupplementaryViewSizeBlock)supplementViewSize;


@end
