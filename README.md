# RCSceneLoginKit

[![CI Status](https://img.shields.io/travis/彭蕾/RCSceneLoginKit.svg?style=flat)](https://travis-ci.org/彭蕾/RCSceneLoginKit)
[![Version](https://img.shields.io/cocoapods/v/RCSceneLoginKit.svg?style=flat)](https://cocoapods.org/pods/RCSceneLoginKit)
[![License](https://img.shields.io/cocoapods/l/RCSceneLoginKit.svg?style=flat)](https://cocoapods.org/pods/RCSceneLoginKit)
[![Platform](https://img.shields.io/cocoapods/p/RCSceneLoginKit.svg?style=flat)](https://cocoapods.org/pods/RCSceneLoginKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements


## Installation

RCSceneLoginKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RCSceneLoginKit', '0.1.0'
```

## Usage

```Objective-c
    // 配置baseUrl 和 bussinessToken
    [RCSLoginConfig configWithBaseUrl:@""
                       bussinessToken:@""
                            isOverSea:NO];
                            
    // 跳转登录页
    RCSLoginViewController *loginVC = [RCSLoginViewController new];
    __weak __typeof__(loginVC) weakLoginVC = loginVC;
    // 设置登录成功的回调
    loginVC.successCompletion = ^(RCSUserInfo * _Nonnull userInfo) {
        __strong __typeof__(weakLoginVC) strongLoginVC = weakLoginVC;
        self.loginSuccessLabel.text = userInfo.description;
        [strongLoginVC dismissViewControllerAnimated:YES completion:nil];
    };
    loginVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    loginVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:loginVC animated:YES completion:nil];
```

## Author

彭蕾, penglei1@rongcloud.cn

## License

RCSceneLoginKit is available under the MIT license. See the LICENSE file for more info.
