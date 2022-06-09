//
//  UIImage+RCS.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/6.
//

#import "UIImage+RCS.h"
#import "RCSLoginViewController.h"

@implementation UIImage (RCS)

+ (UIImage *)rcs_imageNamed:(NSString *)imageName
                     bundle:(NSString *)bundleName {
    if (bundleName.length <= 0 || imageName.length <= 0) {
        return nil;
    }
    
    NSBundle *bundle = [NSBundle bundleForClass:[RCSLoginViewController class]];
    NSURL *bundleURL = [bundle URLForResource:bundleName withExtension:@"bundle"];
    if (!bundleURL) {
        return nil;
    }
    
    NSBundle *imageBundle = [NSBundle bundleWithURL:bundleURL];
    return [UIImage imageNamed:imageName inBundle:imageBundle compatibleWithTraitCollection:nil];
}

/// 根据颜色生产图片
+ (UIImage *)rcs_imageWithColor:(UIColor *)color {
    return [self rcs_imageWithColor:color size:CGSizeMake(1, 1)];
}

/// 根据颜色生产图片
+ (UIImage *)rcs_imageWithColor:(UIColor*)color size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
