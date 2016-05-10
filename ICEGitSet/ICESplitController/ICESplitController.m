//
//  ICESplitController.m
//  ICEGitSet
//
//  Created by WLY on 16/5/10.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICESplitController.h"
#import "ICESplitChiledsBaseVC.h"


#define ICEMasterViewFrame CGRectMake(0, 0, self.masterViewWidth, CGRectGetHeight(self.view.bounds))

#define ICEDetailViewFrame CGRectMake(self.masterViewWidth + self.lineSapcing, 0, CGRectGetWidth(self.view.bounds) - self.masterViewWidth - self.lineSapcing, CGRectGetHeight(self.view.bounds))


@interface ICESplitController ()

@end

@implementation ICESplitController

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark - init
- (instancetype)initWithMasterViewController:(ICESplitChiledsBaseVC *)masterViewController withDetailViewController:(ICESplitChiledsBaseVC *)detailViewController{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor lightGrayColor];
        self.lineSapcing = 15;
        self.masterViewWidth = 300;
        
        [self p_configMasterVC:masterViewController];
        [self p_configDetailsVC:detailViewController];
        [self p_layoutSubviews];
    }
    return self;
}

/**
 *  配置主视图
 */
- (void)p_configMasterVC:(ICESplitChiledsBaseVC *)masterViewController{
    _masterViewController = masterViewController;
    [_masterViewController setValue:self forKey:@"splitController"];
    [self addChildViewController:_masterViewController];
    [self.view addSubview:_masterViewController.view];

}

/**
 *  配置详情视图
 */
- (void)p_configDetailsVC:(ICESplitChiledsBaseVC *)detailViewController{
    _detailViewController = detailViewController;
    [_detailViewController setValue:self forKey:@"splitController"];
    [self addChildViewController:_detailViewController];
    [self.view addSubview:_detailViewController.view];
}
/**
 *  设置主视图与详情视图的frame;
 */
- (void)p_layoutSubviews{
    
    self.masterViewController.view.frame = ICEMasterViewFrame;
    self.detailViewController.view.frame = ICEDetailViewFrame;
    
    
}

#pragma mark - 设置实现
- (void)setMasterViewWidth:(CGFloat)masterViewWidth{

    if (_masterViewWidth != masterViewWidth) {
        _masterViewWidth = masterViewWidth;
        [self p_layoutSubviews];
    }
}

- (void)setLineSapcing:(CGFloat)lineSapcing{

    if (_lineSapcing != lineSapcing) {
        _lineSapcing = lineSapcing;
        [self p_layoutSubviews];
    }
}


#pragma mark - 跳转详情视图

- (void)transitionDetaiViewControllerToViewController:(ICESplitChiledsBaseVC *)toViewController withAnimation:(BOOL)animation{

    if (self.detailViewController != toViewController) {
        toViewController.view.frame = ICEDetailViewFrame;
        
        if (animation == YES) {
            ICESplitChiledsBaseVC *tempVC = self.detailViewController;
            [self p_configDetailsVC:toViewController];
            
            self.detailViewController.view.alpha = 0;

            [UIView animateWithDuration:0.25 animations:^{
                tempVC.view.alpha = 0;
                self.detailViewController.view.alpha = 1;
                
            } completion:^(BOOL finished) {
                
                [tempVC.view removeFromSuperview];
                [tempVC removeFromParentViewController];
            }];
            
        }else{
            [self p_configDetailsVC:toViewController];
        }
    }
}

@end
