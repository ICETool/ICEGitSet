//
//  ICEPullDownMenuView.h
//  ICEPullDownMenu
//
//  Created by WLY on 16/4/25.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICESegmentView.h"

typedef void (^SelectedBlock) (NSIndexPath *indexPath);

@interface ICEPullDownMenuView : UIView

@property (nonatomic, assign) CGFloat cell_h;//选项单元格的高度
@property (nonatomic, strong) ICESegmentView *segmentView;//分段控件
@property (nonatomic, strong) NSArray *datasource;//下拉菜单单元格数据
@property (nonatomic, assign) CGSize segmentSize;//分段控制器的大小
@property (nonatomic, strong) NSArray *rightDatasoure;//右侧

- (instancetype)initWithTitles:(NSArray *)titles withFrame:(CGRect)frame;


- (void)didSelectedCompletion:(SelectedBlock)completion;

@end
