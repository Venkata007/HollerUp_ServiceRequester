//
//  CompletedCell.swift
//  HollerUp
//
//  Created by Vamsi on 25/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit

class CompletedCell: UITableViewCell {

    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var slotLbl: UILabel!
    @IBOutlet weak var callDurationLbl: UILabel!
    @IBOutlet weak var earningsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
