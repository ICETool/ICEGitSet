//
//  ICEPuddDownMenuView.m
//  ICEPullDownMenu
//
//  Created by WLY on 16/4/25.
//  Copyright © 2016年 ICE. All rights reserved.
//

const static NSInteger cell_tag = 1000;
const static NSInteger title_tag = 1100;
const static NSInteger img_tag = 1200;
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
        self.selectedColor = [UIColor blueColor];
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

- (void)setCurrentSelectedIndex:(NSInteger)currentSelectedIndex{

    if (_currentSelectedIndex != currentSelectedIndex) {
        _currentSelectedIndex = currentSelectedIndex;
       
        for (int i =0 ; i < self.datasource.count; i ++) {
            UIView *other_cell = [self viewWithTag:cell_tag + i];
            UILabel *other_titleLable = [other_cell viewWithTag:title_tag + i];
            UIImageView *other_imgV = [other_cell viewWithTag:img_tag + i];
            
            other_imgV.highlighted = NO;
            other_titleLable.highlighted = NO;
        }
    }
    if (currentSelectedIndex >= 0) {
        UIView *other_cell = [self viewWithTag:cell_tag + currentSelectedIndex];
        UILabel *other_titleLable = [other_cell viewWithTag:title_tag + currentSelectedIndex];
        UIImageView *other_imgV = [other_cell viewWithTag:img_tag + currentSelectedIndex];
        
        other_imgV.highlighted = !other_imgV.highlighted;
        other_titleLable.highlighted = !other_titleLable.highlighted;
  
    }
}

/**
 *  指定下标的单元格 (为单元格设置两种状态)
 */
- (UIView *)p_cellWithTitle:(NSString *)title
                  withIndex:(NSInteger)index
                  withFrame:(CGRect)frame{
    CGFloat img_w = 20 ;
    
    UIView *cell = [[UIView alloc] init];
    cell.frame = frame;
    cell.tag = cell_tag + index;
    
    __block UILabel *titleLable= [[UILabel alloc] init];
    titleLable.text = title;
    titleLable.tag = title_tag + index;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = self.tinColor;
    titleLable.highlightedTextColor = self.selectedColor;
    titleLable.font = UIFontWithSize(14);
    titleLable.backgroundColor = [UIColor clearColor];
    [cell addSubview:titleLable];
    
    
    CGFloat title_w = sizeWithString(title, 1000, 1000, titleLable.font).width;
    CGFloat title_x = (frame.size.width - title_w - img_w ) / 2 + 2;
    
    titleLable.frame = CGRectMake(title_x, 0, title_w, frame.size.height);
    
    UIImageView *imgV = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"icon-arrowdown"]];
    imgV.highlightedImage = [UIImage imageNamed:@"icon-arrowdown-active"];
    imgV.frame = CGRectMake(title_w + title_x, (cell.height - img_w) / 2, img_w, img_w);
    imgV.tag = img_tag + index;
    [cell addSubview:imgV];
    
    
    UIView *partLine = [[UIView alloc] init];
    partLine.backgroundColor = [UIColor darkGrayColor];
    partLine.frame = CGRectMake(cell.width,(cell.height - 20) / 2, 1, 20);
    [cell addSubview: partLine];
    
    
    __weak typeof(self) weakSelf = self;
    [cell whenTouchedUp:^{

        weakSelf.currentSelectedIndex = index;
        //点击回调
        if (weakSelf.cellBlcok) {
            weakSelf.cellBlcok(index, titleLable.highlighted);
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
