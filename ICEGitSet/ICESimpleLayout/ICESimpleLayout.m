//
//  GMXSimpleLayout.m
//  UI_Lession(UICollectionView)
//
//  Created by WLY on 16/1/25.
//  Copyright © 2016年 蓝鸥科技. All rights reserved.
//


static CGSize defaultCellSize;


#import "ICESimpleLayout.h"


@interface ICESimpleLayout ()
@property (nonatomic, assign) NSUInteger                    numberOfItems;//总的单元格数量
@property (nonatomic, strong) NSMutableArray                *itemsAtts;//所有单元格属性
@property (nonatomic, strong) NSMutableArray                *cellHeights;//每一行中所有单元格的高度
@property (nonatomic, strong) NSMutableArray                *suppmetViewAtts;//所有辅助视图属性
@property (nonatomic, assign) CGFloat                       contentHeight;//内容区域总高度

@property (nonatomic, copy  ) ICECellSizeBlock              cellSizeBlock;
@property (nonatomic, copy  ) ICESectionHeightBlock         sectionHeightBlock;
@property (nonatomic, copy  ) ICESupplementaryViewBlock     supplementaryViewBlock;
@property (nonatomic, copy  ) ICESupplementaryViewSizeBlock supplementaryViewSizeBlock;

@end

@implementation ICESimpleLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        self.interItemSpacing = 5;
        self.lineItemSpacing = 5;
        self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        defaultCellSize = CGSizeMake(40, 40);
    }
    return self;
}

-(NSMutableArray *)itemsAtts{

    if (!_itemsAtts) {
        _itemsAtts = [NSMutableArray array];
    }
    return _itemsAtts;
}

- (NSMutableArray *)cellHeights{

    if (!_cellHeights) {
        _cellHeights = [NSMutableArray array];
    }
    return _cellHeights;
}

- (NSMutableArray *)suppmetViewAtts{

    if (!_suppmetViewAtts) {
        _suppmetViewAtts = [NSMutableArray array];
    }
    return _suppmetViewAtts;
}



- (void)p_layoutAllItems{

    //计算内容区域的最终宽度
    self.contentHeight = self.sectionInset.top ;
    CGFloat x = self.sectionInset.left;
    
    NSInteger sections = self.collectionView.numberOfSections;
    for (int i = 0;  i < sections ; i ++) {
        
        self.contentHeight += self.sectionInset.top ;
        CGFloat preSection_Y = self.contentHeight;
        
#pragma mark -区头size回调
        //如果代理返回高度,则使用代理返回的高度, 如果代理未实现则返回0
        if (self.supplementaryViewSizeBlock) {
            CGSize size = self.supplementaryViewSizeBlock(i,SupplementaryTypeHeader);
#pragma mark -区头视图回调
            if (self.supplementaryViewBlock) {
                UIView *headerView = self.supplementaryViewBlock(i,SupplementaryTypeHeader);
                headerView.frame = CGRectMake(x, self.contentHeight, size.width, size.height);
                [self.collectionView addSubview:headerView];
            }
            self.contentHeight += size.height;
        }
        
#pragma mark - 布局单元格
        self.contentHeight += [self p_layoutItemsWithItem_y:self.contentHeight withSection:i];
        
        
        
#pragma mark -区尾size回调
        if (self.supplementaryViewBlock) {
            CGSize size = self.supplementaryViewSizeBlock(i,SupplementaryTypeFoot);
#pragma mark -区尾视图回调
            if (self.supplementaryViewBlock) {
                UIView *footView = self.supplementaryViewBlock(i,SupplementaryTypeFoot);
                footView.frame = CGRectMake(x, self.contentHeight, size.width, size.height);
                [self.collectionView addSubview:footView];
            }
            self.contentHeight += size.height;
        }
        
        
        CGFloat currentSection_h = self.contentHeight - preSection_Y;
#pragma mark - 分区高度回调
        //分区高度回调
        if (self.sectionHeightBlock) {
            self.sectionHeightBlock(i,currentSection_h);
        }
    }
}


- (CGFloat)p_layoutItemsWithItem_y:(CGFloat)item_y withSection:(NSInteger)section{
    
    //获取单元格的总数量
    self.numberOfItems = [self.collectionView numberOfItemsInSection:section];
    //计算内容区域的最终宽度
    CGFloat contentWidth = CGRectGetWidth(self.collectionView.bounds) - self.sectionInset.left - self.sectionInset.right;

    CGFloat sectionHeight = 0;//保存当前分区高度
    CGFloat item_x = self.sectionInset.left;

    for (int i = 0;  i < self.numberOfItems; i ++) {

        //创建indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        //创建属性模型对象
        UICollectionViewLayoutAttributes *attrubutes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
#pragma mark - 单元格size 回调
        //计算frame
        if (self.cellSizeBlock) {
            defaultCellSize = self.cellSizeBlock(indexPath);
        }

        CGFloat nextCell_x = item_x + defaultCellSize.width ;
        if (nextCell_x >= contentWidth) {
            item_x = self.sectionInset.left;
            item_y += (self.lineItemSpacing + defaultCellSize.height);
            sectionHeight += [self p_getMaxValue:self.cellHeights] + self.lineItemSpacing;//获取当前分区总高度
            [self.cellHeights removeAllObjects];
        }

        attrubutes.frame = CGRectMake(item_x, item_y,defaultCellSize.width, defaultCellSize.height);
        //保存在属性数组中
        [self.itemsAtts addObject:attrubutes];
        [self.cellHeights addObject:@(defaultCellSize.height)];
        item_x += defaultCellSize.width + self.interItemSpacing; //更新 x
    }
        sectionHeight += [self p_getMaxValue:self.cellHeights];
    return sectionHeight ;
}

/**
 *  获取指定数组中的最大值
 */
- (CGFloat)p_getMaxValue:(NSMutableArray *)cellHeigths{

    CGFloat maxValue = 0;
    for (int i = 0 ; i < cellHeigths.count; i ++) {
        if ([cellHeigths[i] floatValue] > maxValue) {
            maxValue = [cellHeigths[i] floatValue];
        }
    }
    return maxValue;
}

- (void)prepareLayout{

    [super prepareLayout];

    [self p_layoutAllItems];
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //为当前区域返回对应保存属性模型的数组
    return self.itemsAtts;
}



- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if (elementKind == UICollectionElementKindSectionHeader) {
        return self.suppmetViewAtts[indexPath.section];

    }else{
        return nil;
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //为每个单元格分发对应的属性模型的对象
    return self.itemsAtts[indexPath.item];
}

- (CGSize)collectionViewContentSize
{
    CGSize contentSize = CGSizeMake(CGRectGetWidth(self.collectionView.bounds), self.contentHeight);
    return contentSize;
}





#pragma mark - blcok
/**
 *  为布局对象返回单元格size
 */
- (void)returnCellSize:(ICECellSizeBlock)cellSize{
    _cellSizeBlock = cellSize;
}

/**
 *  获取分区高度
 */
- (void)getSectionHeight:(ICESectionHeightBlock)sectionHeight{
    _sectionHeightBlock = sectionHeight;
}


/**
 *  返回辅助视图(区头,区尾)
 */
- (void)returnSupplementaryView:(ICESupplementaryViewBlock)supplementView{
    _supplementaryViewBlock = supplementView;
}
/**
 *  返回辅助视图size(区头,区尾)
 */
- (void)returnSupplementaryViewSize:(ICESupplementaryViewSizeBlock)supplementViewSize{
    _supplementaryViewSizeBlock = supplementViewSize;
}

@end
