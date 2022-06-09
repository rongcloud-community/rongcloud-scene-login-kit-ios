//
//  RCSUIAdaptor.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/6.
//

#import "RCSUIAdaptor.h"

@interface RCSUIAdaptor ()

@property (nonatomic, assign) CGFloat scale;

@end

@implementation RCSUIAdaptor
+ (instancetype)shareInstance {
    static RCSUIAdaptor *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
        manager.scale = 1.0;
    });
    return manager;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [RCSUIAdaptor shareInstance];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [RCSUIAdaptor shareInstance];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [RCSUIAdaptor shareInstance];
}

+ (void)designWithSize:(CGSize)size {
    [RCSUIAdaptor shareInstance].scale = MIN(kScreen_WIDTH, kScreen_HEIGHT) / MIN(size.width, size.height);
}

+ (CGFloat)reSize:(CGFloat)width {
    return ceil(width * [RCSUIAdaptor shareInstance].scale);
}

@end
