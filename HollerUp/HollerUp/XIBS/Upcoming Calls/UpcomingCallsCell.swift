//
//  UpcomingCallsCell.swift
//  HollerUp
//
//  Created by Vamsi on 27/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class UpcomingCallsCell: UICollectionViewCell {

    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var viewInView: UIView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ez.runThisInMainThread {
            self.viewInView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.black, radius: 2.0, opacity: 0.35 ,cornerRadius : 8)
            self.weekDay.roundCorners(corners: [.topLeft,.topRight], radius: 8.0)
            self.durationLbl.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 8.0)
        }
    }
    override var isSelected: Bool{
        didSet(newValue){
            if newValue{
                self.time.backgroundColor = .secondaryColor
                self.durationLbl.backgroundColor = .secondaryColor
                self.time.textColor = .textColor
            }else{
                self.time.backgroundColor = .whiteColor
                self.durationLbl.backgroundColor = .whiteColor
                self.time.textColor = .themeColor
            }
        }
    }
}
