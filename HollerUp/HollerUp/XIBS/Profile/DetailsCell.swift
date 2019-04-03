//
//  DetailsCell.swift
//  HollerUp
//
//  Created by Vamsi on 12/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var professionLbl: UILabel!
    @IBOutlet weak var experienceLbl: UILabel!
    @IBOutlet weak var feePerMinLbl: UILabel!
    @IBOutlet weak var aboutMeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
