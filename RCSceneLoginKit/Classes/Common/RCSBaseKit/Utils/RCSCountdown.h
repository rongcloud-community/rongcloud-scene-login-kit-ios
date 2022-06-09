//
//  RCSCountdown.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///倒计时回调
typedef void(^RCSCountdownCallBack)(int timeStr);

///倒计时结束回调
typedef void(^RCSCountdownFinishCallBack)(void);

@interface RCSCountdown : NSObject

/// 首次启动倒计时
/// @param starTime int 时间秒
/// @param countdownCallBack 返回剩余时间 单位秒
/// @param countdownFinishCallBack 倒计时结束回调
- (void)startCountDownWithTime:(int)starTime
             countDownCallBack:(RCSCountdownCallBack)countdownCallBack
       countDownFinishCallBack:(RCSCountdownFinishCallBack)countdownFinishCallBack;

///倒计时停止
- (void)stopCountdown;

///倒计时暂停
- (void)suspendCountdown;

///倒计时启动恢复
- (void)resumeCountdown;

@end

NS_ASSUME_NONNULL_END
