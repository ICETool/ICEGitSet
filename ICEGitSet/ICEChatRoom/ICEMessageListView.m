//
//  ICEMessageListView.m
//  ICEChatDemo
//
//  Created by WLY on 16/5/4.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEMessageListView.h"
#import "ICEMessageModel.h"
#import "ICEMessageBaseCell.h"
#import "UIScrollView+ICEAdd.h"

@interface ICEMessageListView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *datasource;//设置历史消息
@property (strong, nonatomic)  UITableView *tableView;


@end


@implementation ICEMessageListView
@synthesize datasource = _datasource;


- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    self.backgroundColor = [UIColor clearColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - lazy load


- (NSMutableArray *)datasource{
    
    if (!_datasource) {
        _datasource = [NSMutableArray array];
        
    }
    return _datasource;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        self.tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        [_tableView registerClass:[ICEMessageBaseCell class] forCellReuseIdentifier:@"CELL"];

        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}


#pragma makr - subviews


#pragma mark - UITableViewDelegate&& UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ICEMessageModel *model = self.datasource[indexPath.row];
    ICEMessageBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];

    [cell setValueWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ICEMessageModel *model = self.datasource[indexPath.row];

    return model.messageContentSize.height + CELLSpacing * 4 + CELLNameLabel_H ;
}



#pragma mark - 添加消息

- (void)setMessages:(NSArray *)messages{

    self.datasource = [messages mutableCopy];
    [self.tableView reloadData];
}

- (void)addMessages:(NSArray *)messages{

    if (self.datasource.count < 1) {
        [self.datasource addObjectsFromArray:messages];
        [self.tableView reloadData];
    }else{
    
        NSMutableArray *indexPaths = [NSMutableArray array];
        
        for (int i = 0; i < messages.count; i ++) {
            NSInteger count = self.datasource.count  ;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:count + i inSection:0];
            [indexPaths addObject:indexPath];
        }
        
        [self.datasource addObjectsFromArray:[messages copy]];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        [self scrollerToBottom];
    }

}

- (void)addOneMessage:(ICEMessageModel *)message{

    [self addMessages:@[message]];
    
}


/**
 *  显示最后一条消息 (调用后延迟0.2秒实现)
 */
- (void)scrollerToBottom{

    [self performSelector:@selector(p_scrollerToBottomAction) withObject:nil afterDelay:0.25];
    
}

- (void)p_scrollerToBottomAction{

    if (self.tableView.contentSize.height >= self.tableView.height - 10) {
        [self.tableView scrollToBottom];
    }
}

@end
