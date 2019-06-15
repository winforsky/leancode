//
//  SILeanManager.m
//  leancode
//
//  Created by zsp on 2019/6/15.
//  Copyright © 2019 woop. All rights reserved.
//

#import "SILeanManager.h"

#import <AVOSCloud/AVOSCloud.h>

#import "SILeanViewController.h"

NSString * const SIAPPID = @"AJJvxETvTgLskV89ACmu7ncL-gzGzoHsz";
NSString * const SIAPPKEYID = @"B7xnrC22EjXOwVv8nsMGAQoW";

@interface SILeanManager ()

@property(nonatomic, assign) BOOL isDebug;

@end

@implementation SILeanManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static SILeanManager *leanManager;
    dispatch_once(&onceToken, ^{
        leanManager = [[[self class] alloc] init];
    });
    return leanManager;
}

- (instancetype) init {
    if(self=[super init]){
        _isDebug=YES;
    }
    return self;
}

/**
 注册APP
 在application:didFinishLaunchingWithOptions: 中调用
 */
- (void)registerApp {
    //注册APP
    [AVOSCloud setApplicationId:SIAPPID clientKey:SIAPPKEYID];
    //开启调试日志
    [AVOSCloud setAllLogsEnabled:self.isDebug];
}

/**
 保存测试数据
 */
- (void)saveTestData {
    AVObject *testObject = [AVObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"https://www.jianshu.com/" forKey:@"testkey"];
    [testObject save];
}

- (void)queryTestDataCallBack:(SICallBack)callback; {
    AVQuery *query = [AVQuery queryWithClassName:@"TestObject"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (NSDictionary *dict in objects) {
                if (callback) {
                    callback([dict objectForKey:@"testkey"]);
                }
                break;
            }
        }
    }];
}

- (BOOL)shouldOpenFor:(NSString*)desUrl {
    if ([desUrl hasPrefix:@"http://"] || [desUrl hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}

- (NSString*)handleError:(NSError *)error {
    //来自LeanCloud 返回的错误
    if([error.domain isEqualToString: kLeanCloudErrorDomain]) {
        return error.localizedFailureReason;
    }else {
        return error.localizedDescription;
    }
}

- (void)showRequestVC {
    [[SILeanManager shareInstance] queryTestDataCallBack:^(NSString*  _Nonnull data) {
        if (data.length>0) {
            if ([[SILeanManager shareInstance] shouldOpenFor:data]) {
                SILeanViewController *destVC = [[SILeanViewController alloc] init];
                destVC.desUrl=data;
                [UIApplication sharedApplication].keyWindow.rootViewController=destVC;
            }
        }
    }];
}

@end
