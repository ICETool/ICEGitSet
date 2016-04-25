//
//  GMXSearchBar.m
//  WLYDoctor
//
//  Created by WLY on 16/1/27.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ICESearchBar.h"
#import "Masonry.h"


@interface ICESearchBar ()<UITextFieldDelegate>

@property (strong, nonatomic)  UITextField *searchTF;
@property (strong, nonatomic)  UIImageView *rightImageView;
@property (nonatomic, strong) SearchBarBlock searchBlock;



@end

@implementation ICESearchBar


#pragma mark - init

- (instancetype)init{
    self = [super init];
    if (self ) {
        self.backgroundColor = [UIColor whiteColor];
        self.searchTF.backgroundColor = [UIColor clearColor];
        self.rightImageView.backgroundColor = [UIColor clearColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

#pragma mark - lazy load

- (UITextField *)searchTF{

    if (!_searchTF) {
         _searchTF = [[UITextField alloc] init];
        _searchTF.placeholder = @"请出入要查找的病人姓名,检查类型";
        _searchTF.delegate = self;
        _searchTF.textAlignment = NSTextAlignmentCenter;
        _searchTF.font = UIFontWithSize(14);
        _searchTF.returnKeyType = UIReturnKeyDone;
        [self addSubview:_searchTF];
        [_searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(self.rightImageView.mas_left).with.offset(- 10);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _searchTF;
}

- (UIImageView *)rightImageView{

    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
        [self addSubview:_rightImageView];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).with.offset(- 10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
    return _rightImageView;
}


- (void)setTitle:(NSString *)title{

    if (_title != title) {
        _title = title;
        self.searchTF.placeholder = _title;
    }
    
}
#pragma mark - TFDelegate
- (void)textFieldChanged{
    
       if (self.searchBlock) {
        self.searchBlock(self.searchTF.text);
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.searchTF resignFirstResponder];
    
    return YES;
}

- (BOOL)resignFirstResponder{

    [self.searchTF resignFirstResponder];
    return YES;
}

- (void)removeFromSuperview{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super removeFromSuperview];

}

- (void)updateSearchBar:(SearchBarBlock)completion{
    _searchBlock = completion;
}

@end
