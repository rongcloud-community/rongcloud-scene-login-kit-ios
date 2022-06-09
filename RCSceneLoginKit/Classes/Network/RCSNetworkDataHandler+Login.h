//
//  RCSNetworkDataHandler+Login.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/8.
//

#import <RCSceneLoginKit/RCSceneLoginKit.h>
#import "RCSNetworkHeader.h"
#import "RCSNetworkDataHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCSNetworkDataHandler (Login)

/// 登录验证码
- (void)sendCodeWithParams:(NSDictionary * _Nullable)params
           completionBlock:(RCSNetworkCompletion _Nullable)completionBlock;

/// 登录
- (void)loginWithParams:(NSDictionary * _Nullable)params
        completionBlock:(RCSNetworkCompletion _Nullable)completionBlock;

@end

NS_ASSUME_NONNULL_END
