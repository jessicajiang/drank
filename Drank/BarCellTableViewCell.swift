//
//  BarCellTableViewCell.swift
//  Drank
//
//  Created by Jessica Jiang on 8/16/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import UIKit

class BarCellTableViewCell: UITableViewCell {

    @IBOutlet weak var barNameLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var barImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
