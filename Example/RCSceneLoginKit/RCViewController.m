//
//  RCViewController.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 06/02/2022.
//  Copyright (c) 2022 彭蕾. All rights reserved.
//

#import "RCViewController.h"
#import <RCSceneLoginKit/RCSceneLoginKit.h>

@interface RCViewController ()
@property (weak, nonatomic) IBOutlet UILabel *loginSuccessLabel;

@end

@implementation RCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [RCSLoginConfig configWithBaseUrl:@"https://rcrtc-api.rongcloud.net/"
                       bussinessToken:@""
                            isOverSea:NO];
    
}

- (IBAction)toLogin:(id)sender {
    RCSLoginViewController *loginVC = [RCSLoginViewController new];
    __weak __typeof__(loginVC) weakLoginVC = loginVC;
    loginVC.successCompletion = ^(RCSUserInfo * _Nonnull userInfo) {
        __strong __typeof__(weakLoginVC) strongLoginVC = weakLoginVC;
        self.loginSuccessLabel.text = userInfo.description;
        [strongLoginVC dismissViewControllerAnimated:YES completion:nil];
    };
    loginVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    loginVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:loginVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
