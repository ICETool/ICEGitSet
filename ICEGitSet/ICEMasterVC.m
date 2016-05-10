//
//  ICEMasterVC.m
//  ICEGitSet
//
//  Created by WLY on 16/5/10.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEMasterVC.h"
#import "ICEdetailVC.h"

@interface ICEMasterVC ()

@end

@implementation ICEMasterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 100, 50, 20);
    [button setTitle:@"detail1" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(10, 200, 50, 20);
    [button1 setTitle:@"detail1" forState:UIControlStateNormal];
    
    [self.view addSubview:button1];
    
    [button handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
       
        ICEdetailVC *detail = [[ICEdetailVC alloc] init];
        detail.view.backgroundColor = [UIColor redColor];
        [self.splitController transitionDetaiViewControllerToViewController:detail withAnimation:YES];
        
    }];
    
    
    [button1 handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        ICEdetailVC *detail = [[ICEdetailVC alloc] init];
        detail.view.backgroundColor = [UIColor blueColor];
        [self.splitController transitionDetaiViewControllerToViewController:detail withAnimation:YES];
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
