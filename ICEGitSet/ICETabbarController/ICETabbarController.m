//
//  GMXTabbarController.m
//  GMXTabbarController
//
//  Created by WLY on 16/2/7.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ICETabbarController.h"
@interface ICETabbarController ()

@end

@implementation ICETabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar addSubview:self.myTabbar];
    self.myTabbar.backgroundColor = [UIColor yellowColor];
    [self.tabBar bringSubviewToFront:self.myTabbar];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (UIView *subView in self.tabBar.subviews) {
        if (![subView isEqual:self.myTabbar]) {
            [subView removeFromSuperview];
        }
    }
}

- (ICETabbar *)myTabbar{

    if (!_myTabbar) {
        _myTabbar = [[ICETabbar alloc] init];
        _myTabbar.frame = self.tabBar.bounds;
        [_myTabbar didSelectedItem:^(NSInteger index) {
            self.selectedIndex = index;
        }];
    }
    return _myTabbar;
}


@end
