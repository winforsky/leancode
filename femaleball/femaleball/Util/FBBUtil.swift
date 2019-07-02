//
//  FBBUtil.swift
//  femaleball
//
//  Created by zsp on 2019/7/2.
//  Copyright © 2019 woop. All rights reserved.
//

import UIKit

class FBBUtil: NSObject {
//    声明和初始化一个 static 的类的常量属性，
//    然后命名那个属性为 shared 来表明这个类的实例是一个单例（默认是共有的）；
    static let shareInsatance = FBBUtil()
    
//    为想要控制和保护的资源声明私有的属性,
//    且只能通过 shared 共享；
    private let xx:String;
    
    private override init() {
        //私有的init函数
//        声明一个私有初始化方法，只有我们的单例类能够初始化它，
//        在 init 的内部，初始化我们想要用于控制的共享资源；
        xx = "120"
    }
    
    
    func loadVCFromStoryboard(withIdentifier identifier: String, storyboardName name: String, bundle storyboardBundleOrNil: Bundle?) -> UIViewController {
        return UIStoryboard(name: name, bundle: storyboardBundleOrNil).instantiateViewController(withIdentifier: identifier)
    }
}
