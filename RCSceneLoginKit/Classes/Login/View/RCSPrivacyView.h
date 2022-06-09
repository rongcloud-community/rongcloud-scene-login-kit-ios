//
//  RCSPrivacyView.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RCSPrivacyTapHandler)(NSString *path, NSString *title);

@interface RCSPrivacyView : UIView

@property (nonatomic, copy) RCSPrivacyTapHandler tapHandler;

- (BOOL)agreeContacts;

@end

NS_ASSUME_NONNULL_END
