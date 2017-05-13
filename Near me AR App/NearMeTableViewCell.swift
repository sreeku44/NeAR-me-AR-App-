//
//  NearMeTableViewCell.swift
//  Near me AR App
//
//  Created by Sreekala Santhakumari on 3/16/17.
//  Copyright © 2017 Klas. All rights reserved.
//

import UIKit

class NearMeTableViewCell: UITableViewCell {
    
    
    @IBOutlet var nearMeLabel: UILabel!
    
    @IBOutlet var nearMeImageView: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
