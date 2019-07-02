//
//  FBBMatchDetailViewController.swift
//  femaleball
//
//  Created by zsp on 2019/7/2.
//  Copyright © 2019 woop. All rights reserved.
//

import UIKit

class FBBMatchDetailViewController: FBBBaseViewController {

    
    @IBOutlet weak var matachDetailTableView: UITableView!
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

}

extension FBBMatchDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FBBMatchDetailCell", for: indexPath)
        return cell;
    }
    
    
}


