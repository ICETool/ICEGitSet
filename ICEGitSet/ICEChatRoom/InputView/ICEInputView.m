//
//  ICEInputView.m
//  ICEChatDemo
//
//  Created by WLY on 16/5/4.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEInputView.h"
#import "ICEChatDemoDefine.h"
#import "ICEPickerController.h"
#import "ICEMP3Recorder.h"
#import "UUProgressHUD.h"

#pragma mark - 协议是否可响应
static BOOL usable_text = NO;
static BOOL usable_voice = NO;
static BOOL usable_image = NO;



@interface ICEInputView ()<UITextViewDelegate,MP3RecorderDelegate>

@property (nonatomic, strong) UIView              *myInputView;//输入视图
@property (nonatomic, strong) UIView              *addView;//辅助视图(打开相册等..)
@property (nonatomic, strong) UITextView          *inputTV;//输入框
@property (nonatomic, strong) UIButton            *voiceBtn;//语音按钮
@property (nonatomic, strong) UIButton            *voiceView;//语音视图

@property (nonatomic,   copy) AddViewBlock        addViewBlock;//显示和隐藏辅助视图时的回调


@property (nonatomic, strong) ICEPickerController *picker;//照片获取器
@property (nonatomic, strong) ICEMP3Recorder      *recorder;//录音




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

- (ICEPickerController *)picker{

    if (!_picker) {
        _picker = [[ICEPickerController alloc] init];
    }
    return _picker;
}

- (ICEMP3Recorder *)recorder{

    if (!_recorder) {
        _recorder = [[ICEMP3Recorder alloc] initWithDelegate:self];
    }
    return _recorder;
}

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
            if (_stateBtn.selected) {
                self.voiceBtn.selected = YES;
                self.voiceView.hidden = YES;
            }
            if (self.addViewBlock) {
                self.addViewBlock(_stateBtn.selected);
            }
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
                [self.voiceView resignFirstResponder];
                self.voiceView.hidden = YES;
                [self.inputTV becomeFirstResponder];
            }else{
                [self.voiceView becomeFirstResponder];
                self.voiceView.hidden = NO;
                [self.inputTV resignFirstResponder];
            }
        }];
        
        
        
    }
    return _voiceBtn;
}

- (UIButton *)voiceView{

    if (!_voiceView) {
        
        _voiceView = [UIButton buttonWithType:UIButtonTypeSystem];
        _voiceView.backgroundColor = [UIColor whiteColor];
        _voiceView.hidden = YES;
        _voiceView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _voiceView.layer.borderWidth = 0.5;
        _voiceView.layer.cornerRadius = 2;
        
        [_voiceView setTitle:@"按住说话" forState:UIControlStateNormal];
        [_voiceView setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _voiceView.titleLabel.font = UIFontWithSize(12);

        
        [_voiceView addTarget:self action:@selector(startRecorder:) forControlEvents:UIControlEventTouchDown];
        
        [_voiceView addTarget:self action:@selector(cancelRecorder:) forControlEvents:UIControlEventTouchDragExit
         ];
        [_voiceView addTarget:self action:@selector(cancelRecorder:) forControlEvents:UIControlEventTouchCancel];
        [_voiceView addTarget:self action:@selector(cancelRecorder:) forControlEvents:UIControlEventTouchDragOutside];
        
        [_voiceView addTarget:self action:@selector(finishRecorder:) forControlEvents:UIControlEventTouchUpInside];
    
        
    }
    return _voiceView;
}

/**
 *  开始录音
 */
- (void)startRecorder:(UIButton *)button{

    [self.recorder startRecorder];
    [UUProgressHUD show];
    [UUProgressHUD changeSubTitle:@"滑动取消"];
}

/**
 *  取消录音
 */
- (void)cancelRecorder:(UIButton *)button{
    
    [self.recorder cancelRecorder];
    [UUProgressHUD dismissWithSuccess:@"cancle"];
}

/**
 *  结束录音
 */
- (void)finishRecorder:(UIButton *)button{
    [self.recorder endRecorder];
    [UUProgressHUD dismissWithSuccess:@"success"];
}

#pragma makr - subviews
- (void)p_subviews{

    [[self layer] setShadowOffset:CGSizeMake(2, 2)];
    [[self layer] setShadowRadius:2];
    [[self layer] setShadowOpacity:1];
    [[self layer] setShadowColor:[UIColor blackColor].CGColor];
    
    [self p_inputView];
    [self p_addView];
}


/**
 *  输入视图
 */
- (void)p_inputView{

    self.myInputView = [[UIView alloc] init];
    self.inputView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.myInputView];

    [self.myInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(ICEInput_InputView_H);
    }];

    //输入框
    [self.myInputView addSubview:self.inputTV];
    [self.inputTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7.5);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(- 60);
        make.height.mas_equalTo(35);
    }];
    
    //语音按钮
    [self.myInputView addSubview:self.voiceBtn];
    [self.voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(- 7.5);
        make.size.mas_equalTo(CGSizeMake(35,35));
    }];
    //状态按钮
    
    [self.myInputView addSubview:self.stateBtn];
    [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- 15);
        make.bottom.mas_equalTo(- 7.5);
        make.size.mas_equalTo(CGSizeMake(40,40));

    }];
    
    
    //语音输入视图
    [self.myInputView addSubview:self.voiceView];
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
    self.addView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.addView];
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myInputView.mas_bottom).with.offset(0.5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIView *partLine = [[UIView alloc] init];
    partLine.backgroundColor = [UIColor lightGrayColor];
    [self.addView addSubview:partLine];
    [partLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    NSArray *imgs = @[[UIImage imageNamed:@"camera"],[UIImage imageNamed:@"picture"]];
    
    CGFloat cell_w = 80;
    CGFloat cell_spacing = 30;
    
    for (int i = 0 ; i < imgs.count; i ++) {
        //打开相机
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setImage:[imgs[i] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        btn.layer.borderWidth = 0.5;
        btn.userInteractionEnabled = YES;
        btn.layer.cornerRadius = 4;
        [self.addView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((cell_spacing + (cell_spacing + cell_w ) * i));
            make.centerY.mas_equalTo(self.addView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(cell_w,cell_w));
        }];
        
        [btn handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
            [self p_handelActionForAddView:i];
        }];
        
    }
}

/**
 *  交互逻辑
 */
- (void)p_interfaction{

    
}

- (void)addViewShowState:(AddViewBlock)completion{

    _addViewBlock = completion;
}
#pragma mark - 功能实现
/**
 *  点击辅助视图中的功能实现 (打开相册 / 打开相机)
 *
 *  @param index
 */
- (void)p_handelActionForAddView:(NSInteger)index{

    //发送图片消息
    
    //打开相机
    if (index == 0 ) {
    
        [self.picker getPictureFromeCamearWithViewController:[ICEPickerController getCurrentVC] completion:^(NSDictionary *imageInfo) {
            
            if ([imageInfo[@"errCode"] intValue] == 1) {
                if (usable_image) {
                    [self.delegate inputView:self withPictureMessage:imageInfo[@"imageURL"]];
                }
            }
    
        }];
    }
    
    //打开相册
    if (index == 1) {
        [self.picker getPictureFromePictureBrowseWithViewController:[ICEPickerController getCurrentVC] completion:^(NSDictionary *imageInfo) {
           
            if ([imageInfo[@"errCode"] intValue] == 1) {
                    if (usable_image) {
                        [self.delegate inputView:self withPictureMessage:imageInfo[@"imageURL"]];
                }
            }
        }];
    }
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


#pragma mark - mpsDelegate
/**
 *  发送语音消息
 */
/**  完成转换时的回调 */
- (void)finfshConvert:(ICEMP3Recorder *)MP3Recorder
        voiceRecorded:(NSString *)recordPath
               length:(float)recordLength{

    DLog(@"%f",recordLength);
    if (usable_voice) {
        [self.delegate inputView:self withVoieMessage:@{@"path" : recordPath, @"length" : @(recordLength)}];
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
