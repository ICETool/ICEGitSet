//
//  ICEDrawerViewController.m
//  ICEDrawerViewController
//
//  Created by WLY on 16/4/21.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEDrawerController.h"
#import "UIGestureRecognizer+ICEAdd.h"


/**
 手指拖动方向 (泛指 当前手指位置相对于手指原点的位置)
 */
typedef enum DrawDirection {

    DrawDirectionLeft  = 1,
    DrawDirectionRight = 2,
    DrawDirectionNone  = 3,
}DrawDirection;

/**
   当前手势影像的有效视图,
 */
typedef enum PanEffectView{
    PanEffectViewLeft  = 1,
    PanEffectViewRight = 0,
    PanEffectViewNone  = 3,

}PanEffectView;

static CGFloat left_w              = 280 ;//左侧视图显示宽度
static CGFloat rihg_w              = 160 ;//右侧视图显示宽度
static CGFloat thresholdValue      = 80 ;//滑动边界值
static CGFloat right_x                   ;//右侧抽屉的初始位置
const static CGFloat mainPageScale = 0.8 ;//打开左侧窗时, 主视图的缩放比例
const static CGFloat leftPageScale = 0.7 ;//左侧视窗默认缩放比例
const static CGFloat leftCenter_X  = 30  ;//左侧视图初始偏移量
const static CGFloat leftAplha     = 0.8  ;//左侧蒙版最大值
const static CGFloat speedf        = 0.7 ;//滑动系数 建议设置 0.5 ~ 1 之间 (必要参数)



@interface ICEDrawerController ()

@property (nonatomic, strong) UIViewController *mainVC;
@property (nonatomic, strong) UIViewController *leftVC;
@property (nonatomic, strong) UIViewController *rightVC;
@property (nonatomic, assign) BOOL             open;//当前是否已经开启抽屉 //默认NO
@property (nonatomic, assign) BOOL             enabelPan;//是否需要根据手指滑动//默认YES
@property (nonatomic, assign) BOOL             enabelChanglePan;//是否改变当前的手势作用范围//默认值为YES;
@property (nonatomic, assign) PanEffectView    panEffectView;//当前手势的有效作用视图//默认3;
@property (nonatomic, assign) DrawDirection    direction;//手指拖动方向(初始意向);//默认3;
@property (nonatomic, strong) UIView           *leftShareView;

@property (nonatomic, strong) UITapGestureRecognizer *tap;//点击手势
@end



@implementation ICEDrawerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
#pragma mark - 初始化方法
- (instancetype)initDrawerViewControllerWithMainVC:(UIViewController *)mainVC
                                           andLeftVC:(UIViewController *)leftVC
                                          andRightVC:(UIViewController *)rightVC{
    self = [super init];
    if (self) {
        
//        left_w         *= SCREEN_RATIO;
//        rihg_w         *= SCREEN_RATIO;
//        thresholdValue *= SCREEN_RATIO;
        right_x        = SCREEN_WIDTH + 20;
        self.enabelPan = YES;
        self.open      = NO;

        self.backgroundImageView.image = [UIImage imageNamed:@"leftbackiamge"];
        [self.view addSubview:self.leftShareView];

        
        [self p_initPanValue];

        self.mainVC  = mainVC;
        self.leftVC  = leftVC;
        self.rightVC = rightVC;
        [self addChildViewController:self.mainVC];
        [self addChildViewController:self.leftVC];
        [self addChildViewController:self.rightVC];
        
        
        
        //初始化缩放比例
        self.leftVC.view.frame     = CGRectMake(0, 0, left_w , SCREEN_HEIGHT);
        self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftPageScale, leftPageScale);
        self.leftVC.view.centerX   = 30;
        [self.view addSubview:self.leftVC.view];

        self.mainVC.view.frame = self.view.bounds;
        [self.view addSubview:self.mainVC.view];

        
        self.rightVC.view.frame           = CGRectMake(right_x, NAVIGATION_BAR_HEIGHT, rihg_w, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT);
        [self p_addShareEffceOnView:self.rightVC.view];
        [self.view addSubview:self.rightVC.view];

        [self p_addPanGestureRecognizer];

    }
    
    return self;
}


/**
 *  初始化拖拽手势相关参数
 */
- (void)p_initPanValue{
    
    self.enabelChanglePan = YES;
    self.panEffectView    = PanEffectViewNone;
    self.direction        = DrawDirectionNone;
    
}

/**
 *  添加阴影效果
 */
- (void)p_addShareEffceOnView:(UIView *)view{

    [[view layer] setShadowOffset:CGSizeMake(10, 10)];
    [[view layer] setShadowRadius:20];
    [[view layer] setShadowOpacity:1];
    [[view layer] setShadowColor:[UIColor blackColor].CGColor];
    
}

#pragma mark - lazy load
- (UIView *)leftShareView{

    if (!_leftShareView) {
        _leftShareView = [[UIView alloc] init];
        _leftShareView.frame = self.view.bounds;
        _leftShareView.backgroundColor = [UIColor blackColor];
        _leftShareView.alpha = leftAplha;
    }
    return _leftShareView;
}


- (UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.frame = self.view.bounds;
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_backgroundImageView];
        [self.view insertSubview:_backgroundImageView atIndex:0];
    }
    return _backgroundImageView;
}

#pragma mark - 添加手势

/**
 *  拖拽手势(只对主界面添加拖拽手势, 并设定拖拽视图动画)
 *  如果不需要 则直接返回
 */
- (void)p_addPanGestureRecognizer{

    if (self.enabelPan == NO ) {
        return;
    }
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    pan.maximumNumberOfTouches = 1;
    pan.minimumNumberOfTouches = 1;
    
    [self.mainVC.view addGestureRecognizer:pan];
    
    __weak typeof(self) weakSelf = self;
    //当当前显示的是抽屉视图的时候收, 打开抽屉的手势无效
    [pan addActionBlock:^(id  _Nonnull sender) {
        if (self.enabelPan == NO ) {
            return;
        }

        UIPanGestureRecognizer * panGR = (UIPanGestureRecognizer *)sender;
        UIView *view = panGR.view;//主视图
        double slide_x = [panGR translationInView:view].x * speedf;//当前的拖动距离
        
        
        NSLog(@"%f",slide_x);

        if (weakSelf.enabelChanglePan && slide_x != 0) {
            
            weakSelf.direction = slide_x > 0 ? DrawDirectionRight : DrawDirectionLeft;//当前的手指拖动方向(泛指 当前手指位置相对于手指原点的位置)
            
            if ((!weakSelf.open && weakSelf.direction  == DrawDirectionRight) || (weakSelf.open && weakSelf.leftVC.view.centerX > leftCenter_X && weakSelf.direction == DrawDirectionLeft)) {
                weakSelf.panEffectView = PanEffectViewLeft;
                weakSelf.enabelChanglePan = NO;
            }else if ((!weakSelf.open && self.direction == DrawDirectionLeft) || (weakSelf.open && weakSelf.rightVC.view.left < right_x  && weakSelf.direction == DrawDirectionRight)){
                weakSelf.panEffectView = PanEffectViewRight;
                weakSelf.enabelChanglePan = NO;
            }
        }
       
        
        //判断当前是在对哪个抽屉进行操作(打开和关闭的操作是一样的)
        
        if (weakSelf.panEffectView == PanEffectViewLeft && fabs(slide_x) <= left_w) {
            //对左侧抽屉进行操作
            [weakSelf p_leftViewAnimation:slide_x];
        }
        
        if (weakSelf.panEffectView == PanEffectViewRight && fabs(slide_x) <= rihg_w) {
            //对右侧抽屉进行操作
            [weakSelf p_rightViewAnimation:slide_x];
        }
        
        
        //手势结束后修正位置 查过阈值 确认打开或者关闭抽屉
        if (panGR.state == UIGestureRecognizerStateEnded) {

            //判断当前是在对哪个抽屉进行操作(打开和关闭的操作是一样的)
            if (weakSelf.panEffectView == PanEffectViewLeft) {
            
                if (fabs(slide_x) > thresholdValue) {
                    
                    if (weakSelf.open) {
                        [weakSelf closeLeftVC];
                    }else{
                        [weakSelf openLeftVC];
                    }
                }else{
                    if (weakSelf.open) {
                        [weakSelf openLeftVC];
                    }else{
                        [weakSelf closeLeftVC];
                    }
                }
            
            }
            if (weakSelf.panEffectView == PanEffectViewRight) {
                
                if (fabs(slide_x) > thresholdValue) {
                    if (weakSelf.open) {
                        [weakSelf closeRightVC];
                    }else{
                        [weakSelf openRightVC];
                    }
                }else{
                    
                    if (weakSelf.open) {
                        [weakSelf openRightVC];
                    }else{
                        [weakSelf closeRightVC];
                    }
                }

            }
            
            [self p_initPanValue];
        }
        
    }];
}


/**
 *  左侧抽屉渐变动画
 *
 *  @param slide_x 拖动距离
 */
- (void)p_leftViewAnimation:(double)slide_x{

        UIView *view  = self.mainVC.view;
            //对左侧抽屉进行操作
        
        CGFloat scale ;//缩放比例 (1.0 ~ mainPageScale)
        CGFloat leftScale;//左侧抽屉缩放比例 (leftPageScale ~ 1.0);
        UIView *leftView = self.leftVC.view;
        
        CGFloat scale_spacing = fabs(slide_x) / (left_w);
        [UIView beginAnimations:nil context:nil];
        
        if (self.direction == DrawDirectionLeft) {
            //关闭左抽屉
            scale = mainPageScale + (1 - mainPageScale) * scale_spacing;
            leftScale = 1 - (1 - leftPageScale) * scale_spacing;
            view.left = left_w + slide_x;
            leftView.centerX = left_w * 0.5 + (left_w * 0.5 - leftCenter_X) * slide_x / left_w;
            self.leftShareView.alpha = 0 + scale_spacing * leftAplha;
            NSLog(@"关闭左抽屉");
        }else{
            //打开左抽屉
            scale = 1 - (1 - mainPageScale) * scale_spacing;
            leftScale = leftPageScale + (1 - leftPageScale) * scale_spacing;
            view.left = slide_x;
            leftView.centerX = leftCenter_X + (left_w * 0.5 - leftCenter_X) * view.left / left_w;
            self.leftShareView.alpha = leftAplha - scale_spacing * leftAplha;
            NSLog(@"打开左抽屉");
        }
        
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
        leftView.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale, leftScale);
        
        [UIView commitAnimations];
}

/**
 *  右侧抽屉渐变动画
 *
 *  @param slide_x 拖动距离
 */
- (void)p_rightViewAnimation:(double)slide_x{
        
        [UIView beginAnimations:nil context:nil];
        
        if (self.open && self.direction == DrawDirectionRight && slide_x < rihg_w) {
            //关闭右侧抽屉
            self.rightVC.view.right = right_x + slide_x;
            
            
            NSLog(@"关闭右抽屉");
        }
        
        if (!self.open && self.direction == DrawDirectionLeft && slide_x < rihg_w) {
            //打开右侧抽屉
            self.rightVC.view.left = SCREEN_WIDTH + slide_x;
            NSLog(@"打开关闭右抽屉");
            
        }
        
        self.rightVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        [UIView commitAnimations];
}

/**
 *  添加点击手势, 并屏蔽原有点击返回按钮
 */
- (void)p_addTapGesture{
   
    UIView *titleView = [self.mainVC.view viewWithTag:1000];
    UIButton *leftBtn = [titleView viewWithTag:1100];
    leftBtn.enabled = NO;
    
    self.tap = [[UITapGestureRecognizer alloc] init];
    [self.mainVC.view addGestureRecognizer:self.tap];
    
    __weak typeof(self) weakSelf = self;
    [self.tap addActionBlock:^(id  _Nonnull sender) {
        [weakSelf closeLeftVC];
        [weakSelf closeRightVC];
    }];
    
}

/**
 *  删除手势
 */
- (void)p_removeTapGesture{
    UIView *titleView = [self.mainVC.view viewWithTag:1000];
    UIButton *leftBtn = [titleView viewWithTag:1100];
    leftBtn.enabled = YES;
    
    [self.mainVC.view removeGestureRecognizer:self.tap];
    self.tap = nil;
    
}



#pragma mark - 视图位置调整动画

/**
 *  打开做左视图
 */
- (void)openLeftVC{
    self.open = YES;
    
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, mainPageScale, mainPageScale);
    self.mainVC.view.left = left_w;
    
    self.leftVC.view.centerX = left_w * 0.5;
    self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    
    self.leftShareView.alpha = 0;

    [UIView commitAnimations];
    
    [self p_addTapGesture];
}



/**
 *  关闭左视图
 */
- (void)closeLeftVC{


    self.open = NO;
    [UIView beginAnimations:nil context:nil];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    self.mainVC.view.left = 0;
    
    self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftPageScale, leftPageScale);
    self.leftVC.view.centerX = leftCenter_X;

    self.leftShareView.alpha = leftAplha;

    [UIView commitAnimations];
    [self p_removeTapGesture];
    
}


/**
 *  打开右视图
 */
- (void)openRightVC{

    self.open = YES;
    [UIView beginAnimations:nil context:nil];
    self.rightVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    self.rightVC.view.right = SCREEN_WIDTH;
   
    [UIView commitAnimations];
    [self p_addTapGesture];
    
}


/**
 *  关闭右视图
 */
- (void)closeRightVC{

    self.open = NO;
    
    [UIView beginAnimations:nil context:nil];
    self.rightVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    self.rightVC.view.left = right_x;
    
    [UIView commitAnimations];
    [self p_removeTapGesture];
    
}




#pragma mark - action
- (void)setPanEnable:(BOOL)enable{

    self.enabelPan = enable;
}


@end
