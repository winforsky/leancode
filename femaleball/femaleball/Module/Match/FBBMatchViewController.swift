//
//  FBBMatchViewController.swift
//  femaleball
//
//  Created by zsp on 2019/7/2.
//  Copyright © 2019 woop. All rights reserved.
//

import UIKit

class FBBMatchViewController: FBBBaseViewController {
    
    @IBOutlet weak var leftPlayerLabel: UILabel!
    
    @IBOutlet weak var leftScoreLabel: UILabel!
    
    @IBOutlet weak var rightPlayerLabel: UILabel!
    
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    @IBOutlet weak var backNowButton: UIButton!
    @IBOutlet weak var stopNowButton: UIButton!
    
    var leftTotalScore = 0
    var rightTotalScore = 0
    
    @IBAction func addScore(_ sender: UIButton) {
        if(sender.tag > 20){
            //右边的加分
            rightTotalScore = rightTotalScore + (sender.tag - 20)
            rightScoreLabel.text = "\(rightTotalScore)"
        }else if(sender.tag > 10){
            //左边的加分
            leftTotalScore = leftTotalScore + (sender.tag - 10)
            leftScoreLabel.text = "\(leftTotalScore)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.backNowButton.isEnabled=false;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if let _ = self.navigationController?.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled=false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
//        #selector()语句中,要调用类名.方法名,否则会cash
        if let _ =  self.navigationController?.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled=true
        }
    }
    
    @IBAction func stopNow(_ sender: Any) {
        
        let alertController = UIAlertController(title: "确认操作", message: "确定结束比赛吗？", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "不小心点错了", style: .cancel, handler: { (action) in
            
        }))
        
        weak var weakSelf = self;
        alertController.addAction(UIAlertAction(title: "确定结束", style: .default , handler: { (action) in
            if let strongSelf = weakSelf {
                strongSelf.backNowButton.isEnabled=true;
                strongSelf.stopNowButton.isEnabled=false;
            }
        }))
        
        self.present(alertController, animated: true) {
            
        }
    }
    
    @IBAction func backNow(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
