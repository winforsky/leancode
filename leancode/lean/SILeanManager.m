//
//  SILeanManager.m
//  leancode
//
//  Created by zsp on 2019/6/15.
//  Copyright © 2019 woop. All rights reserved.
//

#import "SILeanManager.h"

#import <AVOSCloud/AVOSCloud.h>
#import <UserNotifications/UserNotifications.h>

#import "SILeanViewController.h"

NSString * const SIAPPID = @"AJJvxETvTgLskV89ACmu7ncL-gzGzoHsz";
NSString * const SIAPPKEYID = @"B7xnrC22EjXOwVv8nsMGAQoW";

@interface SILeanManager ()<UNUserNotificationCenterDelegate>

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


/**
 查询测试数据
 
 @param callback <#callback description#>
 */
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


/**
 判断是否需要下一步操作
 
 @param desUrl <#desUrl description#>
 @return <#return value description#>
 */
- (BOOL)shouldOpenFor:(NSString*)desUrl {
    if ([desUrl hasPrefix:@"http://"] || [desUrl hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}


/**
 错误处理
 
 @param error <#error description#>
 @return <#return value description#>
 */
- (NSString*)handleError:(NSError *)error {
    //来自LeanCloud 返回的错误
    if([error.domain isEqualToString: kLeanCloudErrorDomain]) {
        return error.localizedFailureReason;
    }else {
        return error.localizedDescription;
    }
}


/**
 下一步的操作
 */
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

#pragma mark -
#pragma mark push

/**
 初始化UNUserNotificationCenter
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 中调用
 
 */
- (void)registerForRemoteNotification {
    // iOS10 兼容
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        // 使用 UNUserNotificationCenter 来管理通知
        UNUserNotificationCenter *uncenter = [UNUserNotificationCenter currentNotificationCenter];
        // 监听回调事件
        [uncenter setDelegate:self];
        //iOS10 使用以下方法注册，才能得到授权
        [uncenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert+UNAuthorizationOptionBadge+UNAuthorizationOptionSound)
                                completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [[UIApplication sharedApplication] registerForRemoteNotifications];
                                    });
                                    
                                    //TODO:授权状态改变
                                    NSLog(@"%@" , granted ? @"授权成功" : @"授权失败");
                                }];
        // 获取当前的通知授权状态, UNNotificationSettings
        [uncenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            NSLog(@"%s\nline:%@\n-----\n%@\n\n", __func__, @(__LINE__), settings);
            /*
             UNAuthorizationStatusNotDetermined : 没有做出选择
             UNAuthorizationStatusDenied : 用户未授权
             UNAuthorizationStatusAuthorized ：用户已授权
             */
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                NSLog(@"未选择");
            } else if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                NSLog(@"未授权");
            } else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                NSLog(@"已授权");
            }
        }];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIUserNotificationType types = UIUserNotificationTypeAlert |
        UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType types = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
#pragma clang diagnostic pop
}

/**
 
 - (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken 中调用
 
 */
- (void)saveDeviceToken:(NSData *)deviceToken {
    AVInstallation *currentInstallation = [AVInstallation defaultInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}


/**
 当应用是被通知打开的时候 在这里调用 iOS系统版本 < 10.0 时使用
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 */
- (void)handleNotification:(NSDictionary *)launchOptions {
    if ([[UIDevice currentDevice].systemVersion floatValue] < 10.0) {
        NSDictionary *notificationPayload;
        @try {
            notificationPayload = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        } @catch (NSException *exception) {}
        
        [[SILeanManager shareInstance] showRequestVC];
    }
}


/**
 当应用是被通知打开的时候 在这里调用 iOS系统版本 < 10.0 时使用
 - (void)application:(UIApplication *)application
 didReceiveRemoteNotification:(NSDictionary *)userInfo
 fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler
 */
- (void)handleWhenOpening {
    if ([[UIDevice currentDevice].systemVersion floatValue] < 10.0) {
        [[SILeanManager shareInstance] showRequestVC];
    }
}

/**
 在前台收到推送内容, 执行的方法 iOS系统版本 >= 10.0 时使用
 - (void)userNotificationCenter:(UNUserNotificationCenter *)center
 willPresentNotification:(UNNotification *)notification
 withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
 */
- (void)handleUserNotificationCenter:(UNUserNotificationCenter *)center
             willPresentNotification:(UNNotification *)notification
               withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
//    NSDictionary *userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //TODO:处理远程推送内容
//        NSLog(@"%@", userInfo);
        [[SILeanManager shareInstance] showRequestVC];
    }
    // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    completionHandler(UNNotificationPresentationOptionAlert);
}


/**
 在后台和启动之前收到推送内容, 点击推送内容后，执行的方法 iOS系统版本 >= 10.0 时使用
 - (void)userNotificationCenter:(UNUserNotificationCenter *)center
 didReceiveNotificationResponse:(UNNotificationResponse *)response
 withCompletionHandler:(void (^)())completionHandler
 */
- (void)handleUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //TODO:处理远程推送内容
//        NSLog(@"%@", userInfo);
        [[SILeanManager shareInstance] showRequestVC];
    }
    completionHandler();
}

#pragma mark -
#pragma mark UNUserNotificationCenterDelegate

/**
 iOS系统版本 >= 10.0 时使用

 @param center <#center description#>
 @param notification <#notification description#>
 @param completionHandler <#completionHandler description#>
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    [self handleUserNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
}


/**
 iOS系统版本 >= 10.0 时使用

 @param center <#center description#>
 @param response <#response description#>
 @param completionHandler <#completionHandler description#>
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    [self handleUserNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
}
@end
