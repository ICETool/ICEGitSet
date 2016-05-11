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
    self.myTabbar.barTintColor = [UIColor yellowColor];
    [self setValue:self.myTabbar forKey:@"tabBar"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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

-(void)tabBar:(UITabBar*)atabBar didSelectItem:(UITabBarItem*)item
{
    CATransition* animation = [CATransition animation];
    [animation setDuration:0.5f];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [[self.view layer]addAnimation:animation forKey:@"switchView"];
}

- (void) touchUpInsideItemAtIndex:(NSUInteger)itemIndex
{
    self.selectedIndex=itemIndex;
    
    CATransition* animation = [CATransition animation];
    [animation setDuration:0.5f];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [[self.view layer]addAnimation:animation forKey:@"switchView"];
}

@end
