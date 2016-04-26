//
//  GMXTabbarButtonItem.h
//  GMXTabbarController
//
//  Created by WLY on 16/1/17.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ICETabbarButtonItem : UIView
@property (nonatomic, assign) BOOL selected;



/**
 *  创建实例
 *
 *  @param title       标题
 *  @param selectImage 选中状态的图片
 *  @param normalImage 正常状态的图片
 */
- (instancetype)initWithTitle:(NSString *)title withSelectImage:(UIImage *)selectImage withNormalImage:(UIImage *)normalImage;

@end
