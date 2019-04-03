//
//  PaymentCell.swift
//  HollerUp
//
//  Created by Vamsi on 12/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit

class PaymentCell: UITableViewCell {

    @IBOutlet weak var callIDLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var viewInView: ShadowView!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var yeraLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewInView.cornerRadius = 8.0
        self.viewInView.backgroundColor = .white
        self.monthLbl.roundCorners(corners: [.topLeft,.topRight], radius: 8.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
