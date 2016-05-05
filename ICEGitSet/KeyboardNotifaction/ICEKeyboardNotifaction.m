//
//  ICEKeyboardNotifaction.m
//  ICEGitSet
//
//  Created by WLY on 16/5/5.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEKeyboardNotifaction.h"

@implementation ICEKeyboardNotifaction

+ (void)registerKeyBoardShow:(id)target{
    [[NSNotificationCenter defaultCenter] addObserver:target selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
}
+ (void)registerKeyBoardHide:(id)target{
    [[NSNotificationCenter defaultCenter] addObserver:target selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

+ (void)removekeyBoardShow:(id)target{
    [[NSNotificationCenter defaultCenter] removeObserver:target name:UIKeyboardWillShowNotification object:nil];
    
}
+ (void)removeKeyBoardHide:(id)target{

    [[NSNotificationCenter defaultCenter] removeObserver:target name:UIKeyboardWillHideNotification object:nil];

}

+ (CGRect)returnKeyBoardWindow:(NSNotification *)notification{
    CGRect keyboardEndFrameWindow;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardEndFrameWindow];
    return keyboardEndFrameWindow;
}

+ (double)returnKeyBoardDuration:(NSNotification *)notification{
    double keyboardTransitionDuration;
    [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&keyboardTransitionDuration];
    return keyboardTransitionDuration;
}

+ (UIViewAnimationCurve)returnKeyBoardAnimationCurve:(NSNotification *)notification{
    UIViewAnimationCurve keyboardTransitionAnimationCurve;
    [[notification.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&keyboardTransitionAnimationCurve];
    return keyboardTransitionAnimationCurve;
}




@end
