//
//  RCSVerifyCodeView.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/6.
//

#import "RCSVerifyCodeView.h"
#import "RCSCountdown.h"

@interface RCSVerifyCodeView ()

@property (nonatomic, strong) UILabel *countdownLabel;
@property (nonatomic, strong) UIButton *requestCodeBtn;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) RCSCountdown *countdown;

@end

@implementation RCSVerifyCodeView


- (instancetype)init {
    if (self = [super init]) {
        [self buildLayout];
    }
    return self;
}

- (void)buildLayout {
    [self addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(RCSReSize(180));
        make.top.left.bottom.mas_equalTo(0);
    }];
    [self.codeTextField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];

    
    [self addSubview:self.countdownLabel];
    [self.countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.codeTextField.mas_right).offset(RCSReSize(10));
        make.top.right.bottom.mas_equalTo(0);
    }];
    
    [self addSubview:self.requestCodeBtn];
    [self.requestCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.countdownLabel);
    }];
}

- (void)sendCode {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendVerifyCode)]) {
        [self.delegate sendVerifyCode];
    }
}

- (void)editingChanged:(UITextField *)textField {
    NSString *textString = textField.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(codeTextFieldEditingChanged:)]) {
        [self.delegate codeTextFieldEditingChanged:textString];
    }
}

- (void)setEnable:(BOOL)enable {
    _enable = enable;
    _requestCodeBtn.enabled = enable;
    [_requestCodeBtn setTitleColor:[UIColor rcs_colorWithHex:0x0099FF alpha:enable? 1.0 : 0.3]
                          forState:UIControlStateNormal];
    _requestCodeBtn.layer.borderColor = [UIColor rcs_colorWithHex:0x0099FF alpha:enable? 1.0 : 0.3].CGColor;
}

#pragma mark - public method
- (BOOL)verificationCode {
    NSString *code = self.codeTextField.text;
    return code.length == 6;
}

- (NSString *)verifycode {
    return self.codeTextField.text;
}

- (void)countdownRunning {
    self.countdownLabel.hidden = NO;
    self.requestCodeBtn.hidden = YES;
        
    WeakSelf(self);
    [self.countdown startCountdownWithTime:60 countdownCallBack:^(int timeStr) {
        StrongSelf(weakSelf);
        strongSelf.countdownLabel.text = [NSString stringWithFormat:@"已发送(%ds)",timeStr];
    } countdownFinishCallBack:^{
        StrongSelf(weakSelf);
        strongSelf.countdownLabel.hidden = YES;
        strongSelf.requestCodeBtn.hidden = NO;
        [strongSelf.requestCodeBtn setTitle:@"再次发送" forState:UIControlStateNormal];
    }];
}

#pragma mark - lazy load
- (UILabel *)countdownLabel {
    if (!_countdownLabel) {
        _countdownLabel = [UILabel new];
        _countdownLabel.font = [UIFont systemFontOfSize:14.0];
        _countdownLabel.textAlignment = NSTextAlignmentCenter;
        _countdownLabel.textColor = [UIColor rcs_colorWithHex:0x0099FF];
        _countdownLabel.layer.borderColor = [UIColor rcs_colorWithHex:0xD4D7D9].CGColor;
        _countdownLabel.layer.borderWidth = 1.0;
        _countdownLabel.layer.cornerRadius = 4;
    }
    return _countdownLabel;
}

- (UIButton *)requestCodeBtn {
    if (!_requestCodeBtn) {
        _requestCodeBtn = [UIButton new];
        _requestCodeBtn.backgroundColor = [UIColor whiteColor];
        _requestCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_requestCodeBtn setTitleColor:[UIColor rcs_colorWithHex:0x0099FF alpha:0.3]
                              forState:UIControlStateNormal];
        _requestCodeBtn.enabled = NO;
        [_requestCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _requestCodeBtn.layer.borderColor = [UIColor rcs_colorWithHex:0x0099FF alpha:0.3].CGColor;
        _requestCodeBtn.layer.borderWidth = 1.0;
        _requestCodeBtn.layer.cornerRadius = 4;
        [_requestCodeBtn addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _requestCodeBtn;
}

- (UITextField *)codeTextField {
    if (!_codeTextField) {
        _codeTextField = [UITextField new];
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.backgroundColor = [UIColor whiteColor];
        _codeTextField.font = [UIFont systemFontOfSize:14.0];
        _codeTextField.textColor = [UIColor rcs_colorWithHex:0x333333];
        NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor rcs_colorWithHex:0x9B9B9B],
                                     NSFontAttributeName : [UIFont systemFontOfSize:14.0]};
        _codeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码"
                                                                                attributes:attributes];
        _codeTextField.leftViewMode = UITextFieldViewModeAlways;
        _codeTextField.layer.borderWidth = 1.0;
        _codeTextField.layer.borderColor = [UIColor rcs_colorWithHex:0xD4D7D9].CGColor;
        _codeTextField.layer.cornerRadius = 4;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
        _codeTextField.leftView = leftView;
    }
    return _codeTextField;
}

- (RCSCountdown *)countdown {
    if (!_countdown) {
        _countdown = [RCSCountdown new];
    }
    return _countdown;
}

@end
