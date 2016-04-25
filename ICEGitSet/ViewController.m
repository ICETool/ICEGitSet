//
//  ViewController.m
//  ICEGitSet
//
//  Created by WLY on 16/4/25.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ViewController.h"
#import "ICESearchBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ICESearchBar *searchBar = [[ICESearchBar alloc]init];
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.borderWidth = 1;
    searchBar.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    searchBar.title = @"搜索";
    searchBar.frame = CGRectMake(0, 100, self.view.width, 40);
    [searchBar updateSearchBar:^(NSString *text) {
        NSLog(@"%@",text);
    }];
    [self.view addSubview:searchBar];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
