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
@property (nonatomic, assign) CGRect myFrame;
@property (nonatomic, strong) UITableView *rightTableView;

@end
@implementation ICEPullDownMenuView
@synthesize datasource = _datasource;
@synthesize rightDatasoure = _rightDatasoure;


- (instancetype)initWithTitles:(NSArray *)titles withFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorWithHexA(0x000000, 0.5);
        self.myFrame = frame;
        self.segmentSize = CGSizeMake(frame.size.width, 40 );
        self.cell_h = 40;
        
        self.segmentView = [[ICESegmentView alloc] initWithTitles:titles withFrame:CGRectMake(self.myFrame.origin.x, self.myFrame.origin.y, self.segmentSize.width, self.segmentSize.height)];
        self.height = 0;

        [self whenTouchedUp:^{
            self.datasource = @[];
            self.segmentView.currentSelectedIndex = -1;
        }];
    }
    return self;
}


#pragma mark -  lazy load

- (NSArray *)datasource{
    
    if (!_datasource) {
        _datasource = [NSArray array];
    }
    return _datasource;
}

- (NSArray *)rightDatasoure{

    if (!_rightDatasoure) {
        _rightDatasoure = [NSArray array];
    }
    return _rightDatasoure;
}

- (void)setDatasource:(NSArray *)datasource{
    
    if (_datasource != datasource) {
        _datasource = datasource;
        CGFloat tableView_h = _datasource.count * self.cell_h;
        tableView_h = tableView_h < (self.myFrame.size.height - self.segmentSize.height) ? tableView_h : (self.myFrame.size.height - self.segmentSize.height);
        if (_datasource.count > 0) {
            [UIView animateWithDuration:0.15 animations:^{
                [self.tableView reloadData];
                 self.tableView.frame = CGRectMake(self.myFrame.origin.x,self.myFrame.origin.y + self.segmentSize.height, self.myFrame.size.width, tableView_h);
            }];
            self.height = self.myFrame.size.height;
        }else{
            [UIView animateWithDuration:0.15 animations:^{
                self.tableView.frame = CGRectMake(self.myFrame.origin.x, self.myFrame.origin.y + self.segmentSize.height, self.myFrame.size.width,0);
            } completion:^(BOOL finished) {
                [self.tableView reloadData];
                
            }];
            self.height = 0;
        }
    }
}




- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.segmentSize.height + self.myFrame.origin.y, self.myFrame.size.width,0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.bounces = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
        
        
    }
    return _tableView;
}

- (UITableView *)rightTableView{

    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.segmentSize.height + self.myFrame.origin.y, self.myFrame.size.width,0) style:UITableViewStylePlain];
        _rightTableView.delegate =self;
        _rightTableView.dataSource = self;
        _rightTableView.separatorStyle = UITableViewCellAccessoryNone;
        _rightTableView.bounces = NO;
        [_rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL1"];
    }
    return _rightTableView;
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
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.backgroundColor = [UIColor whiteColor];
    UIView *partLine = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, cell.frame.size.width, 1)];
    partLine.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:partLine];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cell_h;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *selectedIdx = [NSIndexPath indexPathForRow:indexPath.row inSection:self.segmentView.currentSelectedIndex];
    self.datasource = [@[] mutableCopy];
    self.segmentView.currentSelectedIndex = -1;
    if (self.selectedBlock) {
        self.selectedBlock(selectedIdx);
    }
}

- (void)didSelectedCompletion:(SelectedBlock)completion{
    _selectedBlock = completion;
}


- (void)didMoveToSuperview{

    [super didMoveToSuperview];
    DLog(@"%@",self.superview);
    [self.superview addSubview:self.segmentView];
    [self.superview addSubview:self.tableView];
}

@end
