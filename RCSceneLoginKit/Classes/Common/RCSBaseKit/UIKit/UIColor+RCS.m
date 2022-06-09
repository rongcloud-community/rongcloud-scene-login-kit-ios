//
//  UIColor+RCS.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/2.
//

#import "UIColor+RCS.h"

NSMutableDictionary *gs_color_dictionary = nil;

@implementation UIColor (RCS)

+ (UIColor *)rcs_colorWithHex:(int)color {
    return [UIColor rcs_colorWithHex:color alpha:1.0];
}

+ (UIColor *)rcs_colorWithHex:(int)color alpha:(CGFloat)alpha {
    NSString *colorString = [NSString stringWithFormat:@"%06x",color];
    return [UIColor rcs_colorWithHexString:colorString alpha:alpha];
}

+ (UIColor *)rcs_colorWithHexString:(NSString *)color {
    return [UIColor rcs_colorWithHexString:color alpha:1.0];
}

+ (UIColor *)rcs_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    UIColor *retColor = [UIColor clearColor];
    // 过滤字符串——去除空格和特殊字符
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return retColor;
    }
    // 判断前缀
    if ([cString length] > 6) {
        if ([cString hasPrefix:@"0x"]) {
            cString = [cString substringFromIndex:2];
        } else if ([cString hasPrefix:@"0X"]) {
            cString = [cString substringFromIndex:2];
        } else if ([cString hasPrefix:@"#"]) {
            cString = [cString substringFromIndex:1];
        }
    }
    // 最终位数校验
    if ([cString length] != 6) {
        return retColor;
    }
    
    NSString *colorKey = cString;
    if (alpha < 1.00 ) {
        colorKey = [cString stringByAppendingFormat:@"%02d", (int)(alpha * 100)];
    }
    if (!gs_color_dictionary ) {
        gs_color_dictionary = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    retColor = [gs_color_dictionary objectForKey:colorKey];
    if (retColor) {
        return retColor;
    }
    
    //从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.length = 2;
    //R G B
    range.location = 0;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    retColor = [UIColor colorWithRed:((float)r / 255.0f)
                               green:((float)g / 255.0f)
                                blue:((float)b / 255.0f) alpha:alpha];
    
    // ****************************** 存储缓存
    if (retColor && cString) {
        [gs_color_dictionary setObject:retColor forKey:colorKey];
    }
    return retColor;
}

@end
