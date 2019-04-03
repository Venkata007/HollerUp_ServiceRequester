//
//  CollectionViewCell.swift
//  Graph
//
//  Created by Hexadots on 12/03/19.
//  Copyright © 2019 Hexadots. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var quaterLabel: UILabel!
    @IBOutlet weak var viewInView: ShadowView!
    @IBOutlet weak var earningsCountLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var durationGraphLblHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var earningsGraphLblHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var viewInViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var durationGraphLbl: UILabel!
    @IBOutlet weak var earningsGraphLbl: UILabel!
    @IBOutlet weak var viewInViewWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.viewInView.cornerRadius = 8.0
        self.viewInView.backgroundColor = .white
        ez.runThisInMainThread {
            self.quaterLabel.roundCorners(corners: [.topLeft,.topRight], radius: 8.0)
        }
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    override func updateConstraintsIfNeeded() {
        super.updateConstraintsIfNeeded()
    }
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addShadow(){
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.shadowRadius = 2
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
}
