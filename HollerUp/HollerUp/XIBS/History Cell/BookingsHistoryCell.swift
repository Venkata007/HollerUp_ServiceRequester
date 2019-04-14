//
//  BookingsHistoryCell.swift
//  HollerUp
//
//  Created by Vamsi on 09/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class BookingsHistoryCell: UITableViewCell {
    
    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var viewInView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var callIDLbl: UILabel!
    @IBOutlet weak var serviceProviderLbl: UILabel!
    @IBOutlet weak var callDurationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ez.runThisInMainThread {
            self.viewInView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.black, radius: 2.0, opacity: 0.35 ,cornerRadius : 5)
            self.weekDay.roundCorners([.topLeft,.topRight], radius: 5)
            self.yearLbl.roundCorners([.bottomLeft,.bottomRight], radius: 5)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
