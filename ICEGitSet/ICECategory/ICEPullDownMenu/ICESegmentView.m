//
//  ICEPuddDownMenuView.m
//  ICEPullDownMenu
//
//  Created by WLY on 16/4/25.
//  Copyright © 2016年 ICE. All rights reserved.
//

const static NSInteger cell_tag = 1000;
const static NSInteger title_tag = 1100;
#import "ICESegmentView.h"

@interface ICESegmentView ()
@property (nonatomic, copy) SelectCellBlock cellBlcok;
@property (nonatomic, strong) NSMutableArray *datasource;



@end


@implementation ICESegmentView


#pragma mark -  init
- (instancetype)initWithTitles:(NSArray *)titles
                     withFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.datasource = [titles mutableCopy];
        self.tinColor = [UIColor blackColor];
        self.selectedColor = [UIColor  blueColor];
        self.backgroundColor = [UIColor whiteColor];
        [self reloadMenuView];
    }
    return self;
}

#pragma mark - lazy load

- (NSMutableArray *)datasource{
    
    if (!_datasource) {
        _datasource = [NSMutableArray array];
        
    }
    return _datasource;
}



/**
 *  指定下标的单元格 (为单元格设置两种状态)
 */
- (UIView *)p_cellWithTitle:(NSString *)title
                  withIndex:(NSInteger)index
                  withFrame:(CGRect)frame{
    
    
    UIView *cell = [[UIView alloc] init];
    cell.frame = frame;
    cell.tag = cell_tag + index;
    
    __block UILabel *titleLable= [[UILabel alloc] init];
    titleLable.text = title;
    titleLable.tag = title_tag + index;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = self.tinColor;
    titleLable.font = [UIFont systemFontOfSize:14 * 1.3];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.frame = cell.bounds;
    [cell addSubview:titleLable];
    
    CGFloat title_w = sizeWithString(title, 1000, 1000, titleLable.font).width;
    __block UIImageView *imgV = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"icon-arrowdown"]];
    imgV.highlightedImage = [UIImage imageNamed:@"icon-arrowdown-active"];
    imgV.frame = CGRectMake((cell.width + title_w) / 2 + 5, (cell.height - 30) / 2, 30, 30);
    [cell addSubview:imgV];
    
    
    UIView *partLine = [[UIView alloc] init];
    partLine.backgroundColor = self.tinColor;
    partLine.frame = CGRectMake(cell.width,(cell.height - 20) / 2, 1, 20);
    [cell addSubview: partLine];
    
    
    __block BOOL isSelected = NO;
    __weak typeof(self) weakSelf = self;
    [cell whenTouchedUp:^{
        NSLog(@"fdsafs");
        //状态改变
        isSelected = !isSelected;
        imgV.highlighted = isSelected;
        if (isSelected) {
            titleLable.textColor = weakSelf.selectedColor;
        }else{
            titleLable.textColor = self.tinColor;
        }
        //点击回调
        if (self.cellBlcok) {
            self.cellBlcok(index, isSelected);
        }
    }];
    
    
    
    return cell;
}


#pragma mark - public
- (void)reloadMenuView{
    
    [self removeAllSubviews];
    NSInteger count = self.datasource.count;
    CGFloat cell_w = self.width / count;
    for (int i =  0 ; i < count; i ++) {
        UIView *cell = [self p_cellWithTitle:self.datasource[i] withIndex:i withFrame:CGRectMake(i * cell_w, 0, cell_w, self.height)];
        [self addSubview:cell];
    }
}


- (void)didSelectedCell:(SelectCellBlock)completion{

    _cellBlcok = completion;
}
//设置标题
- (void)setTitle:(NSString *)title forIndex:(NSInteger)index{
    
    UIView *cell = [self viewWithTag:cell_tag + index];
    UILabel *titleLable = [cell viewWithTag:title_tag + index];
    titleLable.text = title;
    
}
@end
