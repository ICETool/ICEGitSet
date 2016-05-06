//
//  ViewController.m
//  ICEGitSet
//
//  Created by WLY on 16/4/25.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ViewController.h"
#import "ICEPickerController.h"
#import "ICEPhotoLibrary.h"



@interface ViewController ()

@property (nonatomic, strong) ICEPickerController *picker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"相机" forState:UIControlStateNormal];
    
    
    button.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"相册" forState:UIControlStateNormal];
    button1.frame = CGRectMake(100, 300, 100, 100);
    [self.view addSubview:button1];
    
    self.picker = [[ICEPickerController alloc] init];
    [button handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        [self.picker getPictureFromeCamearWithViewController:self completion:^(NSDictionary *imageInfo) {
            DLog(@"%@",imageInfo);
            if ([imageInfo[@"errCode"] intValue] == 1) {
                [ICEPhotoLibrary getImage:imageInfo[@"imageURL"] fromAlbum:nil success:^(UIImage *image) {
                    DLog(@"image ===%@",image);
                } faliure:^{
                    DLog(@"失败");
                }];
            }
            
        }];
    }];
    
    
    [button1 handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        [self.picker getPictureFromePictureBrowseWithViewController:self completion:^(NSDictionary *imageInfo) {
            DLog(@"%@",imageInfo);
            
            [ICEPhotoLibrary getImage:imageInfo[@"imageURL"] fromAlbum:nil success:^(UIImage *image) {
                DLog(@"image ===%@",image);
            } faliure:^{
                DLog(@"失败");
            }];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
