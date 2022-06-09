//
//  RCSLoginPresenter.h
//  Pods-RCSceneLoginKit_Example
//
//  Created by 彭蕾 on 2022/6/2.
//

#import <Foundation/Foundation.h>
#import "RCSUserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCSLoginPresenter : NSObject

- (void)sendCodeWithPhone:(NSString *)phone
                   region:(NSString *)region
               completion:(void (^) (BOOL success))completion;

- (void)loginWithPhone:(NSString *)phone
                region:(NSString *)region
                  code:(NSString *)code
            completion:(void (^) (RCSUserInfo * _Nullable userInfo))completion;

@end

NS_ASSUME_NONNULL_END
