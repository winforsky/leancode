//
//  SDTool.h
//  structdemo
//
//  Created by zsp on 2019/7/27.
//  Copyright © 2019 woop. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDTool : NSObject


/**
 密码的规则检查
 8-16位密码，至少包含字母，数字，字符中的两种，不含空格

 @param string <#string description#>
 @return <#return value description#>
 */
+ (BOOL)checkPassword:(NSString *)string;

/**
 中国手机号的规则检查
 * 正则：手机号（精确）
 * <p>移动：134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、178、182、183、184、187、188、198</p>
 * <p>联通：130、131、132、145、155、156、175、176、185、186、166</p>
 * <p>电信：133、153、173、177、180、181、189、199</p>
 * <p>全球星：1349</p>
 * <p>虚拟运营商：170</p>
 
 @param string <#string description#>
 @return <#return value description#>
 */
+ (BOOL)checkChineseMobileFormatFor:(NSString*)string;

/**
 非中国手机号的规则检查
 只检查是否上11位的数字
 
 @param string <#string description#>
 @return <#return value description#>
 */
+ (BOOL)checkNonChineseMobileFormatFor:(NSString*)string;

/**
 邮箱格式检查
 
 @param string <#string description#>
 @return <#return value description#>
 */
+ (BOOL)checkEmailFormatFor:(NSString*)string;
@end

NS_ASSUME_NONNULL_END
