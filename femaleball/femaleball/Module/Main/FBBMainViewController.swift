//
//  FBBMainViewController.swift
//  femaleball
//
//  Created by zsp on 2019/7/2.
//  Copyright © 2019 woop. All rights reserved.
//

import UIKit

class FBBMainViewController: FBBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func startMatch(_ sender: Any) {
        let destVC : UIViewController? = FBBUtil.shareInsatance.loadVCFromStoryboard(withIdentifier: "FBBMatchPlayerViewController", storyboardName: "Main", bundle: nil)
        if let toVC = destVC {
            self.navigationController?.pushViewController(toVC, animated: true)
        }
    }
    
    
    
    @IBAction func openHistory(_ sender: Any) {
        let destVC : UIViewController? = FBBUtil.shareInsatance.loadVCFromStoryboard(withIdentifier: "FBBMatchHistoryViewController", storyboardName: "Main", bundle: nil)
        if let toVC = destVC {
            self.navigationController?.pushViewController(toVC, animated: true)
        }
    }
    
    @IBAction func openHelper(_ sender: Any) {
        let destVC : UIViewController? = FBBUtil.shareInsatance.loadVCFromStoryboard(withIdentifier: "FBBHelperViewController", storyboardName: "Main", bundle: nil)
        if let toVC = destVC {
            self.navigationController?.pushViewController(toVC, animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func customUI() {
        super.customUI()
        title = "比赛";
    }
}
