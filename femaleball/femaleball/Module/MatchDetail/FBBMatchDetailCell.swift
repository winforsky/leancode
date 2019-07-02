//
//  FBBMatchDetailCell.swift
//  femaleball
//
//  Created by zsp on 2019/7/2.
//  Copyright © 2019 woop. All rights reserved.
//

import UIKit

class FBBMatchDetailCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
