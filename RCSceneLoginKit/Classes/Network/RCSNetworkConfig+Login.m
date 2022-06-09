//
//  RCSNetworkConfig+Login.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/8.
//

#import "RCSNetworkConfig+Login.h"
#import "RCSNetworkConfig.h"

@implementation RCSNetworkConfig (Login)

#pragma mark - 用户登录
/// 获取登录验证码
+ (RCSNetworkConfig *)sendCodeUrlConfigWith:(NSDictionary *)params {
    return [self configWithUrl:@"user/sendCode"
                        method:RCSHTTPRequestMethodPOST
                        params:params];
}

/// 登录
+ (RCSNetworkConfig *)loginUrlConfigWith:(NSDictionary *)params {
    return [self configWithUrl:@"user/login"
                  rspClassName:@"RCSUserInfo"
                        method:RCSHTTPRequestMethodPOST
                        params:params
                       headers:nil];
}

+ (void)initialize {
    [RCSNetworkConfig configWithBaseUrl:[RCSLoginConfig baseUrl]
                         bussinessToken:[RCSLoginConfig bussinessToken]];
}

@end
