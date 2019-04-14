//
//  NameCell.swift
//  HollerUp
//
//  Created by Vamsi on 12/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class NameCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        TheGlobalPoolManager.cornerAndBorder(self.imgView, cornerRadius: self.imgView.h / 2, borderWidth: 0.5, borderColor: .lightGray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
