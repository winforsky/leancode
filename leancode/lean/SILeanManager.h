//
//  SILeanManager.h
//  leancode
//
//  Created by zsp on 2019/6/15.
//  Copyright © 2019 woop. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^SICallBack)(id data);

@interface SILeanManager : NSObject

+ (instancetype)shareInstance;

- (void)registerApp;

- (void)saveTestData;

- (NSString*)handleError:(NSError *)error;

- (void)queryTestDataCallBack:(SICallBack)callback;

- (BOOL)shouldOpenFor:(NSString*)str;

- (void)showRequestVC;

#pragma mark -
#pragma mark push
/**
 初始化UNUserNotificationCenter
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 中调用
 
 */
- (void)registerForRemoteNotification;

/**
 
 - (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken 中调用
 
 */
- (void)saveDeviceToken:(NSData *)deviceToken;

/**
 当应用是被通知打开的时候 在这里调用 < 10.0
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 */
- (void)handleNotification:(NSDictionary *)launchOptions;

/**
 当应用是被通知打开的时候 在这里调用 < 10.0
 - (void)application:(UIApplication *)application
 didReceiveRemoteNotification:(NSDictionary *)userInfo
 fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler
 */
- (void)handleWhenOpening;



@end

NS_ASSUME_NONNULL_END
