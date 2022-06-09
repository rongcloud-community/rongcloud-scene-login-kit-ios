//
//  RCSLoginViewController.h
//  Pods-RCSceneLoginKit_Example
//
//  Created by 彭蕾 on 2022/6/2.
//

#import <UIKit/UIKit.h>
#import "RCSUserInfo.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^RCSLoginSuccessCompletion)(RCSUserInfo *userInfo);
@interface RCSLoginViewController : UIViewController

@property (nonatomic, strong) RCSLoginSuccessCompletion successCompletion;
- (void)showIn:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
