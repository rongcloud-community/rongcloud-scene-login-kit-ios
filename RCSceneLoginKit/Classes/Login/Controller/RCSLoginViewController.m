//
//  RCSLoginViewController.m
//  Pods-RCSceneLoginKit_Example
//
//  Created by 彭蕾 on 2022/6/2.
//

#import "RCSLoginViewController.h"
#import "RCSPhoneView.h"
#import "RCSVerifyCodeView.h"
#import "RCSPrivacyView.h"
#import <SafariServices/SafariServices.h>
#import "RCSWebViewController.h"
#import "RCSCountryCodeViewController.h"
#import "RCSLoginPresenter.h"

@interface RCSLoginViewController ()<RCSPhoneViewDelegate,RCSVerifyCodeViewDelegate>

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) RCSPhoneView *phoneView;
@property (nonatomic, strong) RCSVerifyCodeView *verifyCodeView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) RCSPrivacyView *privacyView;
@property (nonatomic, strong) RCSLoginPresenter *presenter;

@end

@implementation RCSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildLayout];
}

- (void)dealloc {
    
}

- (void)buildLayout {
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self.view addGestureRecognizer:tap];
    
    [self.view addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_offset(RCSReSize(121));
    }];
    
    [self.view addSubview:self.phoneView];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(RCSReSize(38));
        make.height.mas_equalTo(RCSReSize(40));
        make.top.mas_equalTo(self.logoImageView.mas_bottom).offset(RCSReSize(84));
    }];
    
    [self.view addSubview:self.verifyCodeView];
    [self.verifyCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.phoneView);
        make.top.mas_equalTo(self.phoneView.mas_bottom).offset(RCSReSize(20));
    }];
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.phoneView);
        make.height.mas_equalTo(RCSReSize(44));
        make.top.mas_equalTo(self.verifyCodeView.mas_bottom).offset(RCSReSize(48));
    }];
    
    [self.view addSubview:self.privacyView];
    [self.privacyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).inset(RCSReSize(8));
    }];
}

- (void)tapView:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

#pragma mark - RCSPhoneViewDelegate
- (void)phoneTextFieldEditingChanged:(NSString *)phone {
    self.verifyCodeView.enable = [self.phoneView verificationPhone];
    BOOL enabled = [self.phoneView verificationPhone] && [self.verifyCodeView verificationCode];
    self.loginBtn.backgroundColor =[UIColor rcs_colorWithHex:0x0099FF alpha:enabled? 1.0 : 0.3];
    self.loginBtn.enabled = enabled;
}

- (void)selectCountryCode {
    RCSCountryCodeViewController *countryCodeVC = [RCSCountryCodeViewController new];
    countryCodeVC.selectedHandler = ^(RCSCountryInfo * _Nonnull model) {
        [self.phoneView setRegion:model.code];
    };
    [countryCodeVC showIn:self];
}

#pragma mark - RCSVerifyCodeViewDelegate
- (void)codeTextFieldEditingChanged:(NSString *)code {
    BOOL enabled = [self.phoneView verificationPhone] && [self.verifyCodeView verificationCode];
    self.loginBtn.backgroundColor = [UIColor rcs_colorWithHex:0x0099FF alpha:enabled? 1.0 : 0.3];
    self.loginBtn.enabled = enabled;
}

- (void)sendVerifyCode {
    [self.presenter sendCodeWithPhone:[self.phoneView phone]
                               region:[self.phoneView region]
                           completion:^(BOOL success) {
        if (!success) {
            // 失败
            [SVProgressHUD showErrorWithStatus:@"发送验证码失败"];
            return ;
        }
        // 成功
        [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
        [self handlerCodeSendSuccess];
    }];
}

#pragma mark - private method
- (void)handlerCodeSendSuccess {
    [self.verifyCodeView countdownRunning];
}

- (void)loginBtnClicked {
    [self.view endEditing:YES];
    
    if (![self.privacyView agreeContacts]) {
        [SVProgressHUD showInfoWithStatus:@"请勾选同意注册条款"];
        return ;
    }
    
    [SVProgressHUD show];
    [self.presenter loginWithPhone:[self.phoneView phone]
                            region:[self.phoneView region]
                              code:[self.verifyCodeView verifycode]
                        completion:^(RCSUserInfo * _Nullable userInfo) {
        if (!userInfo) {
            // 失败
            [SVProgressHUD showSuccessWithStatus:@"登录失败"];
            return ;
        }
        // 成功
        [SVProgressHUD dismiss];
        !self.successCompletion ?: self.successCompletion(userInfo);
    }];
}

#pragma mark - lazy load
- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
        _logoImageView.image = RCSLoginImageNamed(@"rc_logo");
    }
    return _logoImageView;
}

- (RCSPhoneView *)phoneView {
    if (!_phoneView) {
        _phoneView = [RCSPhoneView new];
        _phoneView.delegate = self;
    }
    return _phoneView;
}

- (RCSVerifyCodeView *)verifyCodeView {
    if (!_verifyCodeView) {
        _verifyCodeView = [RCSVerifyCodeView new];
        _verifyCodeView.delegate = self;
    }
    return _verifyCodeView;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton new];
        _loginBtn.enabled = NO;
        _loginBtn.backgroundColor =[UIColor rcs_colorWithHex:0x0099FF alpha:0.3];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.cornerRadius = 4;
    }
    return _loginBtn;
}

- (RCSPrivacyView *)privacyView {
    if (!_privacyView) {
        _privacyView = [RCSPrivacyView new];
        WeakSelf(self);
        _privacyView.tapHandler = ^(NSString * _Nonnull path, NSString * _Nonnull title) {
            StrongSelf(weakSelf);
            RCSWebViewController *webVC = [[RCSWebViewController alloc] initWithUrlString:path title:title];
            [webVC showIn:strongSelf];
        };
    }
    return _privacyView;
}

- (RCSLoginPresenter *)presenter {
    if (!_presenter) {
        _presenter = [RCSLoginPresenter new];
    }
    return _presenter;
}

@end
