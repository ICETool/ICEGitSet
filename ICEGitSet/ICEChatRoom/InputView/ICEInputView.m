//
//  ICEInputView.m
//  ICEChatDemo
//
//  Created by WLY on 16/5/4.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEInputView.h"

#define ICEInput_h 50
#define ICEAddView_h 100


#pragma mark - 协议是否可响应
static BOOL usable_text = NO;
static BOOL usable_voice = NO;
static BOOL usable_image = NO;



@interface ICEInputView ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *inputView;//输入视图
@property (nonatomic, strong) UIView *addView;//辅助视图(打开相册等..)
@property (nonatomic, strong) UITextView *inputTV;//输入框
@property (nonatomic, strong) UIButton *voiceBtn;//语音按钮
@property (nonatomic, strong) UIView   *voiceView;//语音视图
@property (nonatomic, copy)   SendMessageBlock sendMessageBlock;//发送消息回调



@end

@implementation ICEInputView



- (instancetype)init{

    self = [super init];
    if (self) {
    }
    return self;
}




- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    self.backgroundColor = [UIColor blueColor];
    [self p_subviews];
    [self p_getDelegateEffectiveness];

}



#pragma mark - lazy load

- (UITextView *)inputTV{

    if (!_inputTV) {
        _inputTV = [[UITextView alloc] init];
        _inputTV.delegate = self;
        _inputTV.font = UIFontWithSize(17);
        _inputTV.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _inputTV.layer.borderWidth = 0.5;
        _inputTV.layer.cornerRadius = 2;
        
    }
    return _inputTV;

}

- (UIButton *)stateBtn{

    if (!_stateBtn) {
        _stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stateBtn setImage:[[UIImage imageNamed:@"iconfont-jikediancanicon09"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_stateBtn setImage:[[UIImage imageNamed:@"iconfont-jikediancanicon09"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        _stateBtn.adjustsImageWhenHighlighted = NO;
        
        [_stateBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
            _stateBtn.selected = !_stateBtn.selected;
//            if (_stateBtn.selected) {
//                self.centerY -= ICEAddView_h;
//            }else{
//                self.centerY += ICEAddView_h;
//            }
        }];
        
    }
    return _stateBtn;
}

- (UIButton *)voiceBtn{

    if (!_voiceBtn) {
        _voiceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_voiceBtn setImage:[[UIImage imageNamed:@"iconfont-yuyin (1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]forState:UIControlStateNormal];
        [_voiceBtn setImage:[[UIImage imageNamed:@"iconfont-jianpan (1)"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        _voiceBtn.tintColor = [UIColor clearColor];
        
        [_voiceBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
            _voiceBtn. selected = !_voiceBtn.selected;
            if (!_voiceBtn.selected ) {
                self.voiceView.hidden = YES;
                [self.inputTV becomeFirstResponder];
            }else{
                self.voiceView.hidden = NO;
                [self.inputTV resignFirstResponder];
            }
        }];
    }
    return _voiceBtn;
}

- (UIView *)voiceView{

    if (!_voiceView) {
        
        UIButton *voiceButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [voiceButton setTitle:@"按住说话" forState:UIControlStateNormal];
        [voiceButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        voiceButton.titleLabel.font = UIFontWithSize(12);

        _voiceView = voiceButton;
        _voiceView.hidden = YES;
        _voiceView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _voiceView.layer.borderWidth = 0.5;
        _voiceView.layer.cornerRadius = 2;
        
        
    }
    return _voiceView;
}


#pragma makr - subviews
- (void)p_subviews{

    [[self layer] setShadowOffset:CGSizeMake(2, 2)];
    [[self layer] setShadowRadius:2];
    [[self layer] setShadowOpacity:1];
    [[self layer] setShadowColor:[UIColor blackColor].CGColor];
    
    [self p_inputView];
    
}


/**
 *  输入视图
 */
- (void)p_inputView{

    self.inputView = [[UIView alloc] init];
    self.inputView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.inputView];

    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(ICEInput_h);
    }];

    //输入框
    [self.inputView addSubview:self.inputTV];
    [self.inputTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7.5);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(- 60);
        make.height.mas_equalTo(35);
    }];
    
    //语音按钮
    [self.inputView addSubview:self.voiceBtn];
    [self.voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(- 7.5);
        make.size.mas_equalTo(CGSizeMake(35,35));
    }];
    //状态按钮
    
    [self.inputView addSubview:self.stateBtn];
    [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- 15);
        make.bottom.mas_equalTo(- 7.5);
        make.size.mas_equalTo(CGSizeMake(40,40));

    }];
    
    
    //语音输入视图
    [self.inputView addSubview:self.voiceView];
    [self.voiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputTV.mas_top);
        make.left.mas_equalTo(self.inputTV.mas_left);
        make.right.mas_equalTo(self.inputTV.mas_right);
        make.height.mas_equalTo(self.inputTV.mas_height);

    }];
}

//辅助视图
- (void)p_addView{

    self.addView = [[UIView alloc] init];
    [self addSubview:self.addView];
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inputView.mas_bottom).with.offset(0.5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
}

/**
 *  交互逻辑
 */
- (void)p_interfaction{

    
}



#pragma mark - textViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=100)
    {
        //控制输入文本的长度
        return  NO;
    }
    if ([text isEqualToString:@"\n"]) {
        if (self.inputTV.text.length > 0) {
            if (usable_text) {
                
                [self.delegate inputView:self withTextMessage:self.inputTV.text];
                self.inputTV.text = @"";
            }
        }
        return NO;
    }
    else
    {
        return YES;
    }
}


/**
 *  获取协议的有效性
 */
- (void)p_getDelegateEffectiveness{

  usable_text  = [self.delegate respondsToSelector:@selector(inputView:withTextMessage:)];
  usable_voice = [self.delegate respondsToSelector:@selector(inputView:withVoieMessage:)];
  usable_image = [self.delegate respondsToSelector:@selector(inputView:withPictureMessage:)];


}


@end
