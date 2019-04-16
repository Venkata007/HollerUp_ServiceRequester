//
//  NewAppointmentCell.swift
//  HollerUp
//
//  Created by Vamsi on 25/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit

class CurrentBookingCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var slotTimeLbl: UILabel!
    @IBOutlet weak var regardingLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.imgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 5)
        TheGlobalPoolManager.cornerAndBorder(imgView, cornerRadius: 8, borderWidth: 0.5, borderColor: .lightGray)
        self.statusBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 5)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
