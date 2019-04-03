//
//  RejectOptionsCell.swift
//  HollerUp
//
//  Created by Vamsi on 26/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit

class RejectOptionsCell: UITableViewCell {

    @IBOutlet weak var radioImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func cellSelected(_ isSelectedValue:Bool){
        if isSelectedValue{
            radioImg.isHighlighted = true
            self.contentView.backgroundColor = .white
        }else{
            radioImg.isHighlighted = false
            self.contentView.backgroundColor = .white
        }
    }
}
