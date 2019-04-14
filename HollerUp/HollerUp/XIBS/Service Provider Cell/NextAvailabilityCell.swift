//
//  NextAvailabilityCell.swift
//  HollerUp
//
//  Created by Vamsi on 09/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class NextAvailabilityCell: UICollectionViewCell {
    @IBOutlet weak var viewInView: UIView!
    @IBOutlet weak var weekdayLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ez.runThisInMainThread {
            self.viewInView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.black, radius: 2.0, opacity: 0.35 ,cornerRadius : 5)
            self.weekdayLbl.roundCorners([.topLeft,.topRight], radius: 5.0)
            self.timeLbl.roundCorners([.bottomLeft,.bottomRight], radius: 5.0)
        }
    }
    override var isSelected: Bool{
        didSet(newValue){
            if newValue{
                self.timeLbl.backgroundColor = .secondaryColor
                self.timeLbl.textColor = .whiteColor
            }else{
                self.timeLbl.backgroundColor = .whiteColor
                self.timeLbl.textColor = .themeColor
            }
        }
    }
}
