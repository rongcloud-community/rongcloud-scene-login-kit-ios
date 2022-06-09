//
//  RCSPrivacyView.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/6.
//

#import "RCSPrivacyView.h"

@interface RCSPrivacyView ()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, copy) NSArray *contactRanges;
@property (nonatomic, copy) NSArray *contactURLs;
@property (nonatomic, copy) NSArray *contactTitles;

@end

@implementation RCSPrivacyView
- (instancetype)init {
    if (self = [super init]) {
        [self buildLayout];
    }
    return self;
}

- (void)buildLayout {
    [self addSubview:self.agreeBtn];
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
        make.width.height.mas_equalTo(20);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.agreeBtn.mas_top);
        make.left.mas_equalTo(self.agreeBtn.mas_right).offset(8);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];
    
    [self addSubview:self.versionLabel];
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(12);
        make.centerX.bottom.mas_equalTo(self);
    }];
}

#pragma mark - public method
- (BOOL)agreeContacts {
    return self.agreeBtn.isSelected;
}

#pragma mark - private method
- (void)tapContent:(UITapGestureRecognizer *)tap {
    CGPoint location = [tap locationInView:tap.view];
    
    NSUInteger glyphIndex = [self glyphIndexForPoint:location];
    
    for (int i = 0; i< self.contactRanges.count; i++) {
        NSRange range = NSRangeFromString(self.contactRanges[i]);
        if (NSLocationInRange(glyphIndex, range)) {
            !_tapHandler ?: _tapHandler(_contactURLs[i], _contactTitles[i]);
            break;
        }
    }
}

- (NSUInteger)glyphIndexForPoint:(CGPoint)point {
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:self.contentLabel.attributedText];
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:self.contentLabel.size];
    textContainer.lineBreakMode = self.contentLabel.lineBreakMode;
    
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    
    return [layoutManager glyphIndexForPoint:point inTextContainer:textContainer];
}

- (NSAttributedString *)privacyAttributedText {
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.alignment = NSTextAlignmentLeft;
    style.lineSpacing = 2.0;
    NSString *registerTitle = @"《注册条款》";
    NSString *privacyTitle = @"《隐私政策》";
    NSString *text = [NSString stringWithFormat:@"同意%@和%@并新登录即注册开通融云开发者账号", registerTitle, privacyTitle];
    NSMutableAttributedString *mAttr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{
        NSParagraphStyleAttributeName : style,
        NSFontAttributeName : [UIFont systemFontOfSize:12.0],
    }];
    
    UIColor *linkColor = [UIColor rcs_colorWithHex:0x0099FF];
    
    NSRange registerRange = [text rangeOfString:registerTitle];
    NSMutableArray *ranges = [NSMutableArray arrayWithCapacity:2];
    NSMutableArray *paths = [NSMutableArray arrayWithCapacity:2];
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:2];
    if (registerRange.location != NSNotFound) {
        [ranges addObject:NSStringFromRange(registerRange)];
        [paths addObject:@"https://cdn.ronghub.com/term_of_service_zh.html"];
        [titles addObject:@"注册条款"];
        [mAttr addAttributes:@{NSForegroundColorAttributeName:linkColor} range:registerRange];
    }
    
    NSRange privacyRange = [text rangeOfString:privacyTitle];
    if (privacyRange.location != NSNotFound) {
        [ranges addObject:NSStringFromRange(privacyRange)];
        [paths addObject:@"https://cdn.ronghub.com/Privacy_agreement_zh.html"];
        [titles addObject:@"隐私政策"];
        [mAttr addAttributes:@{NSForegroundColorAttributeName:linkColor} range:privacyRange];
    }
    
    self.contactRanges = ranges.copy;
    self.contactURLs = paths.copy;
    self.contactTitles = titles.copy;
    return mAttr.copy;
}

- (void)agreeBtnClicked:(UIButton *)btn {
    btn.selected = !btn.isSelected;
}

#pragma mark - lazy load
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor rcs_colorWithHex:0x5C6970];
        _contentLabel.attributedText = [self privacyAttributedText];
        _contentLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContent:)];
        [_contentLabel addGestureRecognizer:tap];
    }
    return _contentLabel;
}

- (UIButton *)agreeBtn {
    if (!_agreeBtn) {
        _agreeBtn = [UIButton new];
        _agreeBtn.backgroundColor = [UIColor whiteColor];
        [_agreeBtn setImage:RCSLoginImageNamed(@"checkbox_normal")
                            forState:UIControlStateNormal];
        [_agreeBtn setImage:RCSLoginImageNamed(@"checkbox_selected")
                            forState:UIControlStateSelected];
        [_agreeBtn addTarget:self action:@selector(agreeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_agreeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 3, 3, 0)];
    }
    return _agreeBtn;
}

- (UILabel *)versionLabel {
    if (!_versionLabel) {
        _versionLabel = [UILabel new];
        _versionLabel.textColor = [UIColor rcs_colorWithHex:0x5C6970];
        _versionLabel.font =  [UIFont systemFontOfSize:12.0];
        NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: @"1.1.0";
        _versionLabel.text = [NSString stringWithFormat:@"融云 RTC%@", version];
    }
    return _versionLabel;
}

@end
