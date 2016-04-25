//
//  ICEPullDownMenuView.m
//  ICEPullDownMenu
//
//  Created by WLY on 16/4/25.
//  Copyright © 2016年 ICE. All rights reserved.
//


#import "ICEPullDownMenuView.h"


@interface ICEPullDownMenuView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy)   SelectedBlock selectedBlock;
@property (nonatomic, assign) CGFloat segment_h;
@end
@implementation ICEPullDownMenuView
@synthesize datasource = _datasource;

- (instancetype)initWithTitles:(NSArray *)titles withFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.cell_h = 40;
        self.segment_h = 40 ;
        self.backgroundColor = [UIColor clearColor];
        
        self.segmentView = [[ICESegmentView alloc] initWithTitles:titles withFrame:CGRectMake(0, 0, frame.size.width, self.segment_h)];        
        [self addSubview:self.segmentView];
    }
    return self;
}


#pragma mark -  lazy load

- (NSMutableArray *)datasource{
    
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)setDatasource:(NSMutableArray *)datasource{
    
    if (_datasource != datasource) {
        _datasource = datasource;
        CGFloat tableView_h = _datasource.count * self.cell_h;
        tableView_h = tableView_h < (self.frame.size.height - self.segment_h) ? tableView_h : (self.frame.size.height - self.segment_h);
        if (_datasource.count > 0) {
            [UIView animateWithDuration:0.15 animations:^{
                [self.tableView reloadData];
                self.tableView.frame = CGRectMake(0, self.segment_h, self.frame.size.width, tableView_h);
            }];
            
        }else{
            [UIView animateWithDuration:0.15 animations:^{
                self.tableView.frame = CGRectMake(0, self.segment_h, self.frame.size.width,0);
            } completion:^(BOOL finished) {
                [self.tableView reloadData];
                
            }];
        }
    }
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.segment_h, self.frame.size.width,0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.bounces = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
        
        [self addSubview:_tableView];
        
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate&& UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = self.datasource[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor whiteColor];
    UIView *partLine = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, cell.frame.size.width, 1)];
    partLine.backgroundColor = [UIColor darkGrayColor];
    [cell addSubview:partLine];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cell_h;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *selectedIdx = [NSIndexPath indexPathForRow:self.segmentView.currentSelectedIndex inSection:indexPath.row];
    self.datasource = [@[] mutableCopy];
    self.segmentView.currentSelectedIndex = -1;
    if (self.selectedBlock) {
        self.selectedBlock(selectedIdx);
    }
}

- (void)didSelectedCompletion:(SelectedBlock)completion{
    _selectedBlock = completion;
}
@end
