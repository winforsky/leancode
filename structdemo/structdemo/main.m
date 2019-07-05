//
//  main.m
//  structdemo
//
//  Created by zsp on 2019/7/5.
//  Copyright © 2019 woop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SDBSTree.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        pointTest();
        selfTest();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
