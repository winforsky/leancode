//
//  FBBMatchPlayerViewController.swift
//  femaleball
//
//  Created by zsp on 2019/7/2.
//  Copyright © 2019 woop. All rights reserved.
//

import UIKit

class FBBMatchPlayerViewController: FBBBaseViewController {

    @IBOutlet weak var choosePlayer: UIPickerView!
    
    @IBAction func clickBackButton(_ sender: Any) {
    }
    var leftPlayer:String?;
    var rightPlayer:String?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
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
        title = "选择比赛队";
        addRightBarButtonItem()
    }
    
    func addRightBarButtonItem() {
        //#selector(startPlay) 转而使用@objc封装的方法
        let rightItem = UIBarButtonItem(title: "开始", style: .plain, target: self, action: #selector(startPlay));
        navigationItem.rightBarButtonItem=rightItem
    }
    
    @objc func startPlay() {
        let destVC : UIViewController? = FBBUtil.shareInsatance.loadVCFromStoryboard(withIdentifier: "FBBMatchViewController", storyboardName: "Main", bundle: nil)
        if let toVC = destVC {
            self.navigationController?.pushViewController(toVC, animated: true)
        }
    }

}

extension FBBMatchPlayerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10;
    }
    
    
}

extension FBBMatchPlayerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "c\(component)r\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            self.leftPlayer="c\(component)r\(row)"
            print("\(self.leftPlayer ?? "default value")")
        }else if (component == 1) {
            self.rightPlayer="c\(component)r\(row)"
            print("\(self.rightPlayer ?? "default value")")
        }
    }
}
