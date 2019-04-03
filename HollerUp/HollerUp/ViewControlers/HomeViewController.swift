//
//  HomeViewController.swift
//  HollerUp
//
//  Created by Vamsi on 08/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class HomeViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var professionLbl: UILabel!
    @IBOutlet weak var experienceLbl: UILabel!
    @IBOutlet weak var setAvailablitySwitch: UISwitch!
    @IBOutlet weak var onlineStatusLbl: UILabel!
    @IBOutlet weak var setAvailabiltyBgView: UIView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var detailsViewInView: UIView!
    @IBOutlet weak var upcomingCallsView: UIView!
    @IBOutlet weak var upcomingCallsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var upcomingRegardingLbl: UILabel!
    @IBOutlet weak var upcomingSlotLbl: UILabel!
    @IBOutlet weak var upcomingNameLbl: NSLayoutConstraint!
    @IBOutlet weak var upcomingProfileImg: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var lastSelectedIndexPath:Int = 0
    
    var dataSource = [[QUATER_TITLE:"Q1",
                       AMOUNT:"1000",
                       DURATION:"100",
                       MONTH:"Jan-Mar"],
                      [QUATER_TITLE:"Q2",
                       AMOUNT:"2000",
                       DURATION:"200",
                       MONTH:"Apr-Jun"],
                      [QUATER_TITLE:"Q3",
                       AMOUNT:"3000",
                       DURATION:"300",
                       MONTH:"July-Sep"],
                      [QUATER_TITLE:"Q4",
                       AMOUNT:"4000",
                       DURATION:"400",
                       MONTH:"Oct-Dec"]] as [AnyObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: CollectionViewCellIdentifiers.UpcomingCallsCell, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellIdentifiers.UpcomingCallsCell)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        let indexPath = self.collectionView.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 70, height: 70)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layout
        self.detailsViewInView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.lightGray, radius: 2.0, opacity: 0.35 ,cornerRadius : 0)
        self.setAvailablitySwitch.onTintColor = .themeColor
        self.setAvailablitySwitch.tintColor = .redColor
        self.setAvailablitySwitch.thumbTintColor = .whiteColor
        self.setAvailablitySwitch.backgroundColor = .secondaryColor1
        self.setAvailablitySwitch.layer.cornerRadius = self.setAvailablitySwitch.bounds.height / 2
        self.graphView.dataReceived = self.dataSource
        TheGlobalPoolManager.cornerAndBorder(self.setAvailabiltyBgView, cornerRadius: 0, borderWidth: 0.5, borderColor: .lightGray)
    }
    //MARK:- IB Action Outlets
}
extension HomeViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.UpcomingCallsCell, for: indexPath as IndexPath) as! UpcomingCallsCell
        cell.isSelected = (lastSelectedIndexPath == indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! UpcomingCallsCell
        guard lastSelectedIndexPath != indexPath.row else {
            return
        }
        collectionView.deselectItem(at: IndexPath.init(row: lastSelectedIndexPath, section: 0), animated: false)
        print("Selected:\(indexPath.row)")
        cell.isSelected = true
        lastSelectedIndexPath = indexPath.row
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70);
    }
}
