//
//  RCSLoginConfig.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/9.
//

#import "RCSLoginConfig.h"
#import <RCSceneNetworkKit/RCSNetworkKit.h>

@interface RCSLoginConfig ()
@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *bussinessToken;
@property (nonatomic, copy) NSString *appChannel;
@property (nonatomic, copy) NSString *appVersion;
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
    [self configWithBaseUrl:baseUrl bussinessToken:bussinessToken isOverSea:isOverSea appChannel:nil appVersion:nil];
}

+ (void)configWithBaseUrl:(NSString *)baseUrl
           bussinessToken:(nullable NSString *)bussinessToken
                isOverSea:(BOOL)isOverSea
               appChannel:(nullable NSString *)channel
               appVersion:(nullable NSString *)version {
    [RCSLoginConfig shared].baseUrl = baseUrl;
    [RCSLoginConfig shared].bussinessToken = bussinessToken;
    [RCSLoginConfig shared].isOverSea = isOverSea;
    [RCSLoginConfig shared].appChannel = channel;
    [RCSLoginConfig shared].appVersion = version;
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

+ (nullable NSString *)appChannel {
    return [RCSLoginConfig shared].appChannel;
}

+ (nullable NSString *)appVersion {
    return [RCSLoginConfig shared].appVersion;
}

@end
