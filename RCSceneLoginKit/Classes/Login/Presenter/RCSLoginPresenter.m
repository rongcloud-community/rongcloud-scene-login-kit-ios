//
//  RCSLoginPresenter.m
//  Pods-RCSceneLoginKit_Example
//
//  Created by 彭蕾 on 2022/6/2.
//

#import "RCSLoginPresenter.h"
#import "RCSNetworkDataHandler+Login.h"

@interface RCSLoginPresenter ()

@property (nonatomic, strong) RCSNetworkDataHandler *dataHandler;

@end

@implementation RCSLoginPresenter

__attribute__((unused)) static NSString * _deviceID() {
    static NSString *did = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        did = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    });
    
    return did;
}

#pragma mark - public method
- (void)sendCodeWithPhone:(NSString *)phone region:(NSString *)region completion:(void (^) (BOOL success))completion {
    NSDictionary *params = @{ @"mobile": phone, @"region": region};
    [self.dataHandler sendCodeWithParams:params
                         completionBlock:^(RCSResponseModel * _Nonnull model) {
        !completion ?: completion(model.code == RCSResponseStatusCodeSuccess);
    }];
}

- (void)loginWithPhone:(NSString *)phone
                region:(NSString *)region
                  code:(NSString *)code
            completion:(void (^) (RCSUserInfo * _Nullable userInfo))completion {
    NSMutableDictionary *params = @{ @"mobile": phone,
                              @"region": region,
                              @"verifyCode": code,
                              @"deviceId": _deviceID() ,
                              @"platform" : @"mobile"}.mutableCopy;
    
    if ([RCSLoginConfig appVersion].length != 0) {
        [params addEntriesFromDictionary:@{@"version":[RCSLoginConfig appVersion]}];
    }
    if ([RCSLoginConfig appChannel].length != 0) {
        [params addEntriesFromDictionary:@{@"channel":[RCSLoginConfig appChannel]}];
    }
    
    [self.dataHandler loginWithParams:params
                      completionBlock:^(RCSResponseModel * _Nonnull model) {
        if (model.code == RCSResponseStatusCodeSuccess) {
            RCSUserInfo *userInfo = (RCSUserInfo *)model.data;
            userInfo.phone = phone;
            !completion ?: completion(userInfo);
        } else {
            // 失败
            [SVProgressHUD showSuccessWithStatus:model.msg ?: @"登录失败"];
            !completion ?: completion(nil);
        }
        
    }];
}

#pragma mark - lazy load
- (RCSNetworkDataHandler *)dataHandler {
    if (!_dataHandler) {
        _dataHandler = [RCSNetworkDataHandler new];
    }
    return _dataHandler;
}

@end
