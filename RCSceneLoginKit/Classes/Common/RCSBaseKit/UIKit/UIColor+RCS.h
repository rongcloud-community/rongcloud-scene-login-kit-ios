//
//  UIColor+RCS.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (RCS)

//16进制颜色转换，支持临时缓存
+ (UIColor *)rcs_colorWithHex:(int)color;
+ (UIColor *)rcs_colorWithHex:(int)color alpha:(CGFloat)alpha;
+ (UIColor *)rcs_colorWithHexString:(NSString *)color;
+ (UIColor *)rcs_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
