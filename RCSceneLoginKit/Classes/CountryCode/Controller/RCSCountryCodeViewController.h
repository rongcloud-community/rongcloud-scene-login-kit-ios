//
//  RCSCountryCodeViewController.h
//  Pods-RCSceneLoginKit_Example
//
//  Created by 彭蕾 on 2022/6/2.
//

#import <UIKit/UIKit.h>
#import "RCSCountryInfo.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^RCSSelectedCountryHandler)(RCSCountryInfo *model);
@interface RCSCountryCodeViewController : UIViewController

@property (nonatomic, copy) RCSSelectedCountryHandler selectedHandler;
- (void)showIn:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
