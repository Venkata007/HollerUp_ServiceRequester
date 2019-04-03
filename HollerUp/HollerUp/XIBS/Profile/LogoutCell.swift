//
//  LogoutCell.swift
//  HollerUp
//
//  Created by Vamsi on 12/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit

class LogoutCell: UITableViewCell {
    
    @IBOutlet weak var `switch`: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.switch.onTintColor = .themeColor
        self.switch.tintColor = .redColor
        self.switch.thumbTintColor = .whiteColor
        self.switch.backgroundColor = .secondaryColor1
        self.switch.layer.cornerRadius = self.switch.bounds.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
