//
//  RCSLoginConfig.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCSLoginConfig : NSObject

+ (void)configWithBaseUrl:(NSString *)baseUrl
           bussinessToken:(nullable NSString *)bussinessToken
                isOverSea:(BOOL)isOverSea;

+ (void)configWithBaseUrl:(NSString *)baseUrl
           bussinessToken:(nullable NSString *)bussinessToken
                isOverSea:(BOOL)isOverSea
               appChannel:(nullable NSString *)channel
               appVersion:(nullable NSString *)version;

+ (NSString *)baseUrl;
+ (BOOL )isOverSea;
+ (nullable NSString *)bussinessToken;
+ (nullable NSString *)appChannel;
+ (nullable NSString *)appVersion;

@end

NS_ASSUME_NONNULL_END
