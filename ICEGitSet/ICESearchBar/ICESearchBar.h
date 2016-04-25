//
//  GMXSearchBar.h
//  WLYDoctor
//
//  Created by WLY on 16/1/27.
//  Copyright © 2016年 WLY. All rights reserved.
//
//
/* 
 搜索视图
 
 GMXSearchBar *searchBar = [[GMXSearchBar alloc]init];
 searchBar.backgroundColor = Global_white;
 
 searchBar.delegate = self;
 self.navigationItem.titleView = searchBar;
 searchBar.bounds = CGRectMake(0, 0, 280 * IPHONE_RATE, NAVIGATION_BAR_HEIGHT - 30);
 

 
 */


typedef void (^SearchBarBlock) (NSString *text);

#import <UIKit/UIKit.h>
@class  ICESearchBar;

@interface ICESearchBar : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *title;

- (void)updateSearchBar:(SearchBarBlock)completion;

@end
