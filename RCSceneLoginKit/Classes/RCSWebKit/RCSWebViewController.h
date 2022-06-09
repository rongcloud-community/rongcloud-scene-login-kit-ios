//
//  RCSWebViewController.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCSWebViewController : UIViewController

- (instancetype)initWithUrlString:(NSString *)urlString title:(NSString *)title;
- (void)showIn:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
