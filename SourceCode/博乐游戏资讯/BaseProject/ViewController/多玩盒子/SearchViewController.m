//
//  SearchViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchDetailViewController.h"
@interface SearchViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *webView;
@end

@implementation SearchViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"召唤师查询";
    }
    return self;
}


- (UIWebView *)webView {
    if(_webView == nil) {
        _webView = [[UIWebView alloc] init];
        //要先添加视图，在delegate
        [self.view addSubview:_webView];

        _webView.delegate = self;
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Factory addMenuItemToVC:self];
    self.view.backgroundColor = [UIColor whiteColor];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://lolbox.duowan.com/phone/playerSearchNew.php?lolboxAction=toInternalWebView"]];
    [self.webView loadRequest:request];

    
}

#pragma mark - webVIew协议方法
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideProgress];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    [self hideProgress];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *path = @"http://lolbox.duowan.com/phone/playerSearchNew.php?lolboxAction=toInternalWebView";
    if (![request.URL.absoluteString isEqualToString:path]) {
        SearchDetailViewController *detailVC = [[SearchDetailViewController alloc]initWithRequest:request];
        [self.navigationController pushViewController:detailVC animated:YES];
        return NO;
    }
    return YES;
}



@end
