//
//  WLYBaseTVC.m
//  Wanliyun
//
//  Created by WLY on 16/3/23.
//  Copyright © 2016年 wlycloud. All rights reserved.
//

#import "ICEBaseTVC.h"

@interface ICEBaseTVC ()
@property (nonatomic, copy) MJRefreshBlock refreshBLock;

@end

@implementation ICEBaseTVC



- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSMutableArray *)datasource{
    
    if (!_datasource) {
        _datasource = [NSMutableArray array];
        
    }
    return _datasource;
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
       
        [self initTableView];
    }
    return _tableView;
}




- (void)initTableView{

    
}

#pragma mark - UITableViewDelegate&& UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell ;
    return cell;
}



#pragma mark - 刷新
- (void)startRefreshCompletion:(MJRefreshBlock)refreshBlock{

    if (!self.tableView.mj_header) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            self.tableView.userInteractionEnabled = NO;
            refreshBlock(@"H");
        }];
    }

}

- (void)startLoadRefreshCompletion:(MJRefreshBlock)refreshBlock{

    
        if (!self.tableView.mj_footer) {
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                _page ++;
                self.tableView.userInteractionEnabled = NO;
                refreshBlock(@"F");
            }];
        }


}

- (void)stopRefresh{

    if (self.tableView.mj_header) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer endRefreshing];
    }
    
    self.tableView.userInteractionEnabled = YES;

}



@end
