//
//  NSBundle+RCS.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/2.
//

#import "NSBundle+RCS.h"

@implementation NSBundle (RCS)

+ (NSBundle *)rcs_bundleWithClass:(Class)className bundleName:(NSString *)bundleName {
    if (!className || !bundleName) {
        return nil;
    }
    NSBundle *mainBundle = [NSBundle bundleForClass:className];
    if (!mainBundle) {
        return nil;
    }
    NSURL *bundleUrl = [mainBundle URLForResource:bundleName withExtension:@"bundle"];
    if (!bundleUrl) {
        return nil;
    }
    return [NSBundle bundleWithURL:bundleUrl];
}

@end
