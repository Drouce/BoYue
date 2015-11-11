//
//  SearchDetailViewController.m
//  BaseProject
//
//  Created by drouce on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "SearchDetailViewController.h"


@interface SearchDetailViewController ()<UIWebViewDelegate>
@property (nonatomic , strong) UIWebView *webView;
@end

@implementation SearchDetailViewController

- (id)initWithRequest:(NSURLRequest *)request {
    if(self = [super init]) {
        self.request = request;
        //退出来，不显示下方栏
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (UIWebView *)webView {
  if(_webView == nil) {
      _webView = [[UIWebView alloc] init];
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
    [Factory addBackItemToVC:self];
    self.title = @"召唤师详情";
    
    [self.webView loadRequest:_request];
    
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
    if (navigationType != 5 ) {
        SearchDetailViewController *detailVC = [[SearchDetailViewController alloc]initWithRequest:request];
        [self.navigationController pushViewController:detailVC animated:YES];
        return NO;
    }
    
    return YES;
}






@end
