//
//  ServiceProviderCell.swift
//  HollerUp
//
//  Created by Vamsi on 09/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit

class ServiceProviderCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var qualificationLbl: UILabel!
    @IBOutlet weak var expLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var starRatingView: FloatRatingView!
    @IBOutlet weak var callBtn: ButtonIconRight!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var farwardBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        TheGlobalPoolManager.cornerAndBorder(imgView, cornerRadius: 8, borderWidth: 0.5, borderColor: .lightGray)
        //self.imgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
        self.collectionView.register(UINib.init(nibName: CollectionViewCellIdentifiers.NextAvailabilityCell, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellIdentifiers.NextAvailabilityCell)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize.init(width: 75, height: 75)
        layout.minimumLineSpacing = 5
        collectionView!.collectionViewLayout = layout
        
        starRatingView.fullImage = #imageLiteral(resourceName: "Star_Full").withColor(.secondaryColor)
        starRatingView.emptyImage = #imageLiteral(resourceName: "Star_Empty").withColor(.secondaryColor)
        starRatingView.halfRatings = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
