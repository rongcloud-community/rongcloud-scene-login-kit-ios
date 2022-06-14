//
//  RCSLoginConfig.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/9.
//

#import "RCSLoginConfig.h"

@interface RCSLoginConfig ()
@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *bussinessToken;
@property (nonatomic, assign) BOOL isOverSea;
@end

@implementation RCSLoginConfig
+ (instancetype)shared {
    static RCSLoginConfig *_shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[RCSLoginConfig alloc] init];
    });
    return _shared;
}

+ (void)configWithBaseUrl:(NSString *)baseUrl bussinessToken:(NSString *)bussinessToken isOverSea:(BOOL)isOverSea {
    [RCSLoginConfig shared].baseUrl = baseUrl;
    [RCSLoginConfig shared].bussinessToken = bussinessToken;
    [RCSLoginConfig shared].isOverSea = isOverSea;
}

+ (NSString *)baseUrl {
    return [RCSLoginConfig shared].baseUrl;
}

+ (NSString *)bussinessToken {
    return [RCSLoginConfig shared].bussinessToken;
}

+ (BOOL )isOverSea {
    return [RCSLoginConfig shared].isOverSea;
}
@end
