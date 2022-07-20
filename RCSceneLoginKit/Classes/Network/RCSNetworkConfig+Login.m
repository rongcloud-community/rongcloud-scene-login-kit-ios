//
//  RCSNetworkConfig+Login.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/8.
//

#import <RCSceneNetworkKit/RCSNetworkKit.h>
#import "RCSNetworkConfig+Login.h"
#import "RCSLoginConfig.h"

@implementation RCSNetworkConfig (Login)

#pragma mark - 用户登录
/// 获取登录验证码
+ (RCSNetworkConfig *)sendCodeUrlConfigWith:(NSDictionary *)params {
    return [self configWithUrl:[[RCSLoginConfig baseUrl] stringByAppendingString:@"user/sendCode"]
                  rspClassName:nil
                        method:RCSHTTPRequestMethodPOST
                        params:params
                       headers:[self login_commonHeaders]];
}

/// 登录
+ (RCSNetworkConfig *)loginUrlConfigWith:(NSDictionary *)params {
    return [self configWithUrl:[[RCSLoginConfig baseUrl] stringByAppendingString:@"user/login"]
                  rspClassName:@"RCSUserInfo"
                        method:RCSHTTPRequestMethodPOST
                        params:params
                       headers:[self login_commonHeaders]];
}

+ (NSDictionary *)login_commonHeaders{
    NSMutableDictionary *header = @{@"Content-Type":@"application/json"}.mutableCopy;
    if ([RCSLoginConfig bussinessToken].length != 0) {
        [header addEntriesFromDictionary:@{@"BusinessToken":[RCSLoginConfig bussinessToken]}];
    }
    return header.copy;
}

@end
