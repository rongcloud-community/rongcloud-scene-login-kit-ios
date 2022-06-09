//
//  RCSBaseConstant.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/8.
//

#ifndef RCSBaseConstant_h
#define RCSBaseConstant_h

/// 屏幕的宽高，受横竖屏影响
#define kScreen_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define kScreen_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define RCSReSize(width) ([RCSUIAdaptor reSize:width])

/// weak self
#define WeakSelf(type) __weak __typeof__(type) weakSelf = type;
#define StrongSelf(type) __strong __typeof__(type) strongSelf = type;

/// login notification
#define kRCSNotificationNameLogin        @"NotificationNameLogin"
#define kRCSNotificationNameLogout       @"NotificationNameLogout"

#endif /* RCSBaseConstant_h */
