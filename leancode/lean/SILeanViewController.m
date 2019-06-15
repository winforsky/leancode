//
//  SILeanViewController.m
//  leancode
//
//  Created by zsp on 2019/6/15.
//  Copyright © 2019 woop. All rights reserved.
//

#import "SILeanViewController.h"
#import <Masonry.h>

#import <WebKit/WebKit.h>

@interface SILeanViewController ()

@property(nonatomic, strong) WKWebView *webView;

@end

@implementation SILeanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self loadData];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)configUI {
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }
    }];
}

- (void)loadData {
    if ([self.desUrl hasPrefix:@"http://"] || [self.desUrl hasPrefix:@"https://"]) {
        
    }else{
        self.desUrl=@"https://www.baidu.com";
    }
    
    NSLog(@"aaa=>desturl = %@", self.desUrl);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.desUrl]]];
}

@end
