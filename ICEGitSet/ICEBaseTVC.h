//
//  WLYBaseTVC.h
//  Wanliyun
//
//  Created by WLY on 16/3/23.
//  Copyright © 2016年 wlycloud. All rights reserved.
//
/**
 *  列表类视图基类, 添加 MJ refresh 的各种调用
 */


#import <UIKit/UIKit.h>
#import "MJRefresh.h"

typedef void(^MJRefreshBlock) (id info);

@interface ICEBaseTVC : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
/**
 *  当前加载的页码 (自动更新)
 */
@property (nonatomic, assign, readonly) __block NSInteger page;


/**
 *  tableView的初始化方法, 此方法中调用tableView 调用
 */
- (void)initTableView;

/**
 *  刷新回调, 调用此放放即添加了下拉刷新, 并自动重置页码.结束时调用 stopRefresh
 */
- (void)startRefreshCompletion:(MJRefreshBlock)refreshBlock;
/**
 *  加载回调, 调用了此方法 即添加了上啦加载功能, 并自动重置页码.结束时调用 stopRefresh
 */
- (void)startLoadRefreshCompletion:(MJRefreshBlock)refreshBlock;
/**
 *  结束刷新 (包括上拉刷新与下拉加载)
 */
- (void)stopRefresh;
@end
