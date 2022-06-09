//
//  RCSPhoneView.h
//  Pods-RCSceneLoginKit_Example
//
//  Created by 彭蕾 on 2022/6/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RCSPhoneViewDelegate <NSObject>

- (void)phoneTextFieldEditingChanged:(NSString *)phone;
- (void)selectCountryCode;
@end

typedef void(^RCSSelectCountryHandler)(void);
@interface RCSPhoneView : UIView

@property (nonatomic, weak) id<RCSPhoneViewDelegate> delegate;
- (BOOL)verificationPhone;
- (NSString *)phone;
- (NSString *)region;
- (void)setRegion:(NSString *)region;

@end

NS_ASSUME_NONNULL_END
