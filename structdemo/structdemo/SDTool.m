//
//  SDTool.m
//  structdemo
//
//  Created by zsp on 2019/7/27.
//  Copyright © 2019 woop. All rights reserved.
//

#import "SDTool.h"

@implementation SDTool

+ (BOOL)checkPassword:(NSString *)string {
    BOOL result=NO;
    //    8-16位密码，不含空格
    //    至少包含字母，数字，字符中的两种，不含空格
    NSString * regex =@"^(?![A-Z]+$)(?![a-z]+$)(?!\\d+$)(?![\\W_]+$)\\S+$";
    NSPredicate * pas= [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];

    return [pas evaluateWithObject:string];
}
+ (BOOL)checkChineseMobileFormatFor:(NSString*)string {
    /**
     * 正则：手机号（精确）
     * <p>移动：134(0-8)、135、136、137、138、139、147、150、151、152、157、158、159、178、182、183、184、187、188、198</p>
     * <p>联通：130、131、132、145、155、156、175、176、185、186、166</p>
     * <p>电信：133、153、173、177、180、181、189、199</p>
     * <p>全球星：1349</p>
     * <p>虚拟运营商：170</p>
     */
    NSString *regex =@"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$";
    NSPredicate *pas= [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pas evaluateWithObject:string];
}

+ (BOOL)checkNonChineseMobileFormatFor:(NSString*)string {
    NSString *regex =@"\\d{11}";
    NSPredicate *pas= [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pas evaluateWithObject:string];
}

+ (BOOL)checkEmailFormatFor:(NSString*)string {
    NSString *regex =@"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    NSPredicate *pas= [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pas evaluateWithObject:string];
}
@end
