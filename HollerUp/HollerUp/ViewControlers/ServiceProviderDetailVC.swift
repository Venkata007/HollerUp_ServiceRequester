//
//  ServiceProviderDetailVC.swift
//  HollerUp
//
//  Created by Vamsi on 09/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ServiceProviderDetailVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headerTitleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var qualificationLbl: UILabel!
    @IBOutlet weak var expLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var starRatingView: FloatRatingView!
    @IBOutlet weak var callBtn: ButtonIconRight!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var farwardBtn: UIButton!
    @IBOutlet weak var descriptionLbl: UILabelPadded!
    @IBOutlet weak var bookCallBtn: UIButton!
    @IBOutlet weak var bookAppointmentBtn: UIButton!
    
    var lastSelectedIndexPath:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(ServiceProviderDetailVC.methodOfReceivedNotification(notification:)), name: Notification.Name("BookAppointment_CancelButton"), object: nil)
        self.collectionView.register(UINib.init(nibName: CollectionViewCellIdentifiers.NextAvailabilityCell, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellIdentifiers.NextAvailabilityCell)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
        layout.itemSize = CGSize.init(width: 75, height: 75)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView!.collectionViewLayout = layout
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        let indexPath = self.collectionView.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        //self.imgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
        TheGlobalPoolManager.cornerAndBorder(imgView, cornerRadius: 8, borderWidth: 0.5, borderColor: .lightGray)
        starRatingView.fullImage = #imageLiteral(resourceName: "Star_Full").withColor(.secondaryColor)
        starRatingView.emptyImage = #imageLiteral(resourceName: "Star_Empty").withColor(.secondaryColor)
        starRatingView.halfRatings = true
        self.bookCallBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
        TheGlobalPoolManager.cornerAndBorder(descriptionLbl, cornerRadius: 10, borderWidth: 0, borderColor: .clear)
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
    @IBAction func bookCallBtn(_ sender: UIButton) {
        self.bookAppointmentPopUpView()
    }
    @IBAction func bookAppointmentBtn(_ sender: Any) {
        self.bookAppointmentPopUpView()
    }
    @IBAction func callBtn(_ sender: UIButton) {
    }
}
extension ServiceProviderDetailVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.NextAvailabilityCell, for: indexPath as IndexPath) as! NextAvailabilityCell
        cell.isSelected = (lastSelectedIndexPath == indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! NextAvailabilityCell
        guard lastSelectedIndexPath != indexPath.row else {
            return
        }
        collectionView.deselectItem(at: IndexPath.init(row: lastSelectedIndexPath, section: 0), animated: false)
        print("Selected:\(indexPath.row)")
        cell.isSelected = true
        lastSelectedIndexPath = indexPath.row
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75);
    }
}
extension ServiceProviderDetailVC{
    //MARK: - Book An Appointmnet Pop Up
    @objc func bookAppointmentPopUpView(){
        let viewCon = BookAnAppointmentPopUp(nibName: "BookAnAppointmentPopUp", bundle: nil)
        self.presentPopupViewController(viewCon, animationType: MJPopupViewAnimationFade)
    }
    @objc func methodOfReceivedNotification(notification: Notification){
        self.dismissPopupViewControllerWithanimationType(MJPopupViewAnimationFade)
    }
}
