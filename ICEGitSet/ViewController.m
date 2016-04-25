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
            menuView.datasource = [@[str,str,str] mutableCopy];
        }else{
            menuView.datasource = [@[] mutableCopy];
        }
    }];
    
    [self.view addSubview:menuView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
