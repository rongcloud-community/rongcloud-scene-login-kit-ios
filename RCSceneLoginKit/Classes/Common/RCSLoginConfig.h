//
//  RCSLoginConfig.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCSLoginConfig : NSObject

+ (void)configWithBaseUrl:(NSString *)baseUrl bussinessToken:(nullable NSString *)bussinessToken isOverSea:(BOOL)isOverSea;

+ (NSString *)baseUrl;
+ (NSString *)bussinessToken;
+ (BOOL )isOverSea;

@end

NS_ASSUME_NONNULL_END
