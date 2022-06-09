//
//  NSBundle+RCS.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (RCS)

+ (NSBundle *)rcs_bundleWithClass:(Class)className bundleName:(NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
