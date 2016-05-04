//
//  ViewController.m
//  ICEGitSet
//
//  Created by WLY on 16/4/25.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ViewController.h"
#import "ICEPullDownMenuView.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    ICEPullDownMenuView *menuView = [[ICEPullDownMenuView alloc] initWithTitles:@[@"设置",@"设置",@"设置"] withFrame:CGRectMake(0, 100, self.view.width, self.view.height - 100)];
    menuView.backgroundColor = [UIColor whiteColor];
    
    [menuView.segmentView didSelectedCell:^(NSInteger index, BOOL selected) {
        if (selected) {
            NSString *str = [NSString stringWithFormat:@"%ld",index];
            if (index == 0 || index == 1) {
                menuView.ddView.leftDatasource = [@[str,str,str] mutableCopy];
                menuView.ddView.rightDatasource = [@[str,str,str] mutableCopy];
            }else{
                menuView.datasource = [@[str,str,str] mutableCopy];
            }
        }else{
            menuView.datasource = [@[] mutableCopy];
            menuView.ddView.leftDatasource = [@[] mutableCopy];
            menuView.ddView.rightDatasource = [@[] mutableCopy];
        }
    }];
    
    [menuView.ddView dieSelected:^(NSInteger idx, NSIndexPath *indexPath) {
        
    }];
    
    [self.view addSubview:menuView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
