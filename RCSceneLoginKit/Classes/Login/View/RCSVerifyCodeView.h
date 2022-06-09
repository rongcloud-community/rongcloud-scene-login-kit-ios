//
//  RCSVerifyCodeView.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RCSVerifyCodeViewDelegate <NSObject>

- (void)codeTextFieldEditingChanged:(NSString *)code;
- (void)sendVerifyCode;

@end

typedef void(^RCSSendCodeHandler)(void);

@interface RCSVerifyCodeView : UIView
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, weak) id<RCSVerifyCodeViewDelegate> delegate;

- (BOOL)verificationCode;
- (NSString *)verifycode;
- (void)countdownRunning;

@end

NS_ASSUME_NONNULL_END
