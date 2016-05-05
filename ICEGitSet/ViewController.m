//
//  ViewController.m
//  ICEGitSet
//
//  Created by WLY on 16/4/25.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ViewController.h"
#import "ICEKeyboardNotifaction.h"


@interface ViewController ()
@property (nonatomic,strong) UITextField *testview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    _testview                 = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, 320, 50)];
    _testview.backgroundColor = [UIColor redColor];
    [self.view addSubview:_testview];
    
    [ICEKeyboardNotifaction registerKeyBoardShow:self];
    [ICEKeyboardNotifaction registerKeyBoardHide:self];

}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    [ICEKeyboardNotifaction removeKeyBoardHide:self];
    [ICEKeyboardNotifaction removekeyBoardShow:self];
}

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    
    CGRect keyboardEndFrameWindow                         = [ICEKeyboardNotifaction returnKeyBoardWindow:notification];
    
    double keyboardTransitionDuration                     = [ICEKeyboardNotifaction returnKeyBoardDuration:notification];
    
    UIViewAnimationCurve keyboardTransitionAnimationCurve = [ICEKeyboardNotifaction returnKeyBoardAnimationCurve:notification];
    
    [UIView animateWithDuration:keyboardTransitionDuration
                          delay:0
                        options:(UIViewAnimationOptions)keyboardTransitionAnimationCurve << 16
                     animations:^{
                         CGFloat  y                     =self.view.bounds.size.height - 50;
                         CGRect frame                   = CGRectMake(0, y, 320, 50);
                         frame.origin.y                -= keyboardEndFrameWindow.size.height;
                         self.testview.frame = frame;
                     } completion:nil];
    
    
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    CGRect keyboardEndFrameWindow                         = [ICEKeyboardNotifaction returnKeyBoardWindow:notification];
    
    double keyboardTransitionDuration                     = [ICEKeyboardNotifaction returnKeyBoardDuration:notification];
    
    UIViewAnimationCurve keyboardTransitionAnimationCurve = [ICEKeyboardNotifaction returnKeyBoardAnimationCurve:notification];
    
    [UIView animateWithDuration:keyboardTransitionDuration
                          delay:0
                        options:(UIViewAnimationOptions)keyboardTransitionAnimationCurve << 16
                     animations:^{
                         CGPoint cen                      = self.testview.center;
                         cen.y                           += keyboardEndFrameWindow.size.height;
                         self.testview.center = cen;
                         
                     } completion:nil];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    /**
     *  触摸屏幕使键盘消失
     */
    [self.view endEditing:true];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
