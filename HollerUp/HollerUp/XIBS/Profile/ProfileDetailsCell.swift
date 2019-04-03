//
//  ProfileDetailsCell.swift
//  HollerUp
//
//  Created by Vamsi on 12/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit

class ProfileDetailsCell: UITableViewCell {
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
