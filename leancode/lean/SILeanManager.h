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

@end

NS_ASSUME_NONNULL_END
