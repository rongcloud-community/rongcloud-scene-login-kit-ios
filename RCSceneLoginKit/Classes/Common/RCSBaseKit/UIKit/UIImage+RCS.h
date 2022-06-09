//
//  UIImage+RCS.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (RCS)

/// 加载bundle资源图片
/// @param imageName 图片名
/// @param bundleName bundle名
+ (UIImage *)rcs_imageNamed:(NSString *)imageName
                     bundle:(NSString *)bundleName;

/// 根据颜色生产图片
+ (UIImage *)rcs_imageWithColor:(UIColor *)color;
/// 根据颜色生产图片
+ (UIImage *)rcs_imageWithColor:(UIColor*)color size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
