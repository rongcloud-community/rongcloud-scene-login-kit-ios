//
//  RCSCountdown.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/7.
//

#import "RCSCountdown.h"

@interface RCSCountdown ()

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, copy) RCSCountdownCallBack countDownCallBack;
@property (nonatomic, copy) RCSCountdownFinishCallBack countDownFinishCallBack;
@property (nonatomic, assign) int timeValue;

@end

@implementation RCSCountdown

/// 首次启动倒计时
- (void)startCountDownWithTime:(int)starTime
             countDownCallBack:(RCSCountdownCallBack)countdownCallBack
       countDownFinishCallBack:(RCSCountdownFinishCallBack)countdownFinishCallBack {
    int seconds = starTime;
    self.countDownCallBack = countdownCallBack;
    self.countDownFinishCallBack = countdownFinishCallBack;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [self stopCountdown];
   
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds];
    dispatch_source_set_event_handler(_timer, ^{
        int interval = [endTime timeIntervalSinceNow];
        self->_timeValue = interval;
        if (interval <= 0) {
            dispatch_source_cancel(self->_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //倒计时结束
                if (self.countDownFinishCallBack) {
                    self.countDownFinishCallBack();
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                //倒计时中
                if (self.countDownCallBack) {
                    self.countDownCallBack(interval);
                }
            });
        }
    });
    dispatch_resume(_timer);
}

///倒计时停止
- (void)stopCountdown {
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
}

///倒计时暂停
- (void)suspendCountdown {
    [self stopCountdown];
}

///倒计时启动恢复
- (void)resumeCountdown {
    if (_timeValue > 0) {
        [self startCountDownWithTime:_timeValue
                   countDownCallBack:self.countDownCallBack
             countDownFinishCallBack:self.countDownFinishCallBack];
    }
}

@end
