//
//  RCSUserInfo.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCSUserInfo : NSObject

@property (nonatomic, copy)   NSString *userId;
@property (nonatomic, copy)   NSString *userName;
@property (nonatomic, copy)   NSString *portrait;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) unsigned long long currentTime;
@property (nonatomic, copy)   NSString *authorization;
@property (nonatomic, copy)   NSString *imToken;
@property (nonatomic, copy)   NSString *phone;

@end

NS_ASSUME_NONNULL_END
