//
//  RCSPhoneView.m
//  Pods-RCSceneLoginKit_Example
//
//  Created by 彭蕾 on 2022/6/2.
//

#import "RCSPhoneView.h"

@interface RCSPhoneView ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *countryCodeLabel;
@property (nonatomic, strong) UIButton *countrySelctedBtn;
@property (nonatomic, strong) UITextField *phoneTextField;

@end

@implementation RCSPhoneView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor rcs_colorWithHex:0xD4D7D9].CGColor;
        self.layer.cornerRadius = 4;
        self.stackView.userInteractionEnabled = YES;

        [self buildLayout];
    }
    return self;
}

- (void)buildLayout {
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self.stackView addArrangedSubview:self.countryCodeLabel];
    [self.countryCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(RCSReSize(45));
    }];
    
    if ([RCSLoginConfig isOverSea]) {
        [self.stackView addArrangedSubview:self.countrySelctedBtn];
        [self.countrySelctedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(RCSReSize(20));
        }];
    }
    
    [self.stackView addArrangedSubview:self.phoneTextField];
    [self.phoneTextField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - public method
- (BOOL)verificationPhone {
    NSString *phone = self.phoneTextField.text;
    if ([RCSLoginConfig isOverSea]) {
        return phone.length >= 6;
    }
    return phone.length == 11;
}

- (NSString *)phone {
    return self.phoneTextField.text;
}

- (NSString *)region {
    return self.countryCodeLabel.text;
}

- (void)editingChanged:(UITextField *)textField {
    NSString *textString = textField.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(phoneTextFieldEditingChanged:)]) {
        [self.delegate phoneTextFieldEditingChanged:textString];
    }
}

- (void)setRegion:(NSString *)region {
    self.countryCodeLabel.text = region;
}

#pragma mark - private method
- (void)selectCountry {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCountryCode)]) {
        [self.delegate selectCountryCode];
    }
}

#pragma mark - lazy load
- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [UIStackView new];
        _stackView.distribution = UIStackViewDistributionFillProportionally;
    }
    return _stackView;
}

- (UILabel *)countryCodeLabel {
    if (!_countryCodeLabel) {
        _countryCodeLabel = [UILabel new];
        _countryCodeLabel.font = [UIFont systemFontOfSize:14.0];
        _countryCodeLabel.textColor = [UIColor rcs_colorWithHex:0x9B9B9B];
        _countryCodeLabel.textAlignment = NSTextAlignmentRight;
        _countryCodeLabel.text = @"+86";
        [_countryCodeLabel sizeToFit];
        _countryCodeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCountry)];
        [_countryCodeLabel addGestureRecognizer:tap];
    }
    return _countryCodeLabel;
}

- (UIButton *)countrySelctedBtn {
    if (!_countrySelctedBtn) {
        _countrySelctedBtn = [UIButton new];
        _countrySelctedBtn.backgroundColor = [UIColor whiteColor];
        [_countrySelctedBtn setImage:RCSLoginImageNamed(@"country_select_indicator")
                            forState:UIControlStateNormal];
        [_countrySelctedBtn addTarget:self action:@selector(selectCountry) forControlEvents:UIControlEventTouchUpInside];
    }
    return _countrySelctedBtn;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [UITextField new];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        _phoneTextField.font = [UIFont systemFontOfSize:14.0];
        _phoneTextField.textColor = [UIColor rcs_colorWithHex:0x333333];
        NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor rcs_colorWithHex:0x9B9B9B], NSFontAttributeName : [UIFont systemFontOfSize:14.0]};
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号"
                                                                                attributes:attributes];
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
        _phoneTextField.leftView = leftView;
    }
    return _phoneTextField;
}

@end
