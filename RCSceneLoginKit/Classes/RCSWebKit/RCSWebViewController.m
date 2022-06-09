//
//  RCSWebViewController.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/2.
//

#import "RCSWebViewController.h"
#import <WebKit/WebKit.h>
@interface RCSWebViewController ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *titleString;

@end

@implementation RCSWebViewController

- (instancetype)initWithUrlString:(NSString *)urlString title:(NSString *)title {
    if (self = [super init]) {
        self.urlString = urlString;
        self.titleString = title;
    }
    return self;
}

- (void)showIn:(UIViewController *)controller {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    nav.navigationBar.translucent = NO;
    nav.navigationBar.barTintColor = [UIColor whiteColor];
    nav.navigationBar.backgroundColor = [UIColor whiteColor];
    [controller presentViewController:nav animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildLayout];
    
    if ([self.urlString hasPrefix:@"http"]) {
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:request];
    } else {
        NSURL *url = [NSURL fileURLWithPath:self.urlString];
        [self.webView loadFileURL:url allowingReadAccessToURL:url];
    }
    
}

- (void)buildLayout {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.titleString;
    UIImage *image = [RCSLoginImageNamed(@"back_indicator_image") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithImage:image
                                             style:UIBarButtonItemStylePlain
                                             target:self action:@selector(back)];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(0);
    }];
    
}

- (void)back {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [WKWebView new];
    }
    return _webView;
}

@end
