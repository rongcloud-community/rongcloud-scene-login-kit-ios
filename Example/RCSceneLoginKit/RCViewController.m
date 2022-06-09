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

    [RCSLoginConfig configWithBaseUrl:<#(nonnull NSString *)#>
                       bussinessToken:<#(nonnull NSString *)#>
                            isOverSea:NO];
    
}

- (IBAction)toLogin:(id)sender {
    RCSLoginViewController *loginVC = [RCSLoginViewController new];
    loginVC.successCompletion = ^(RCSUserInfo * _Nonnull userInfo) {
        self.loginSuccessLabel.text = userInfo.description;
    };
    [loginVC showIn:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
