//
//  SearchViewController.swift
//  HollerUp
//
//  Created by Vamsi on 09/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import SDWebImage

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var filterBtn: ButtonIconRight!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageSliderView: ImageSlideshow!
    @IBOutlet weak var imagePageControl: UIPageControl!
    var imagesArray = [#imageLiteral(resourceName: "Img4"),#imageLiteral(resourceName: "Img3"),#imageLiteral(resourceName: "Img1"),#imageLiteral(resourceName: "Img2"),#imageLiteral(resourceName: "Img5")]
    var bannerImages = [ImageSource]()
    
    var lastSelectedIndexPath:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: TableViewCellIdentifiers.ServiceProviderCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.ServiceProviderCell)
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        for img in  imagesArray{
            let imageSource = ImageSource(image:img)
            self.bannerImages.append(imageSource)
        }
        self.imageSlideShow()
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
}
extension SearchViewController : ImageSlideshowDelegate{
    func imageSlideShow(){
        imageSliderView.setImageInputs(bannerImages)
        imageSliderView.contentScaleMode = .scaleToFill
        imageSliderView.slideshowInterval = 5.0
        imageSliderView.pageIndicator?.tintColor1 = .clear
        imageSliderView.pageIndicator?.currentPageTintColor1 = .clear
        imageSliderView.delegate = self
        self.imagePageControl.numberOfPages = self.imagesArray.count
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.openSliderImage(_:)))
        imageSliderView.addGestureRecognizer(tapGesture)
    }
    @objc func openSliderImage(_ sender:UIGestureRecognizer){
        imageSliderView.presentFullScreenController(from: self)
    }
    func pageControllerPageChanged(_ viewCon: ImageSlideshow, page: Int) {
        self.imagePageControl.page = page
    }
}
extension SearchViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.ServiceProviderCell) as! ServiceProviderCell
        cell.farwardBtn.tag = indexPath.row
        cell.farwardBtn.addTarget(self, action: #selector(pushingToProviderDetailVC), for: .touchUpInside)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.reloadData()
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushingToProviderDetailVC()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 285
    }
}
extension SearchViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.NextAvailabilityCell, for: indexPath as IndexPath) as! NextAvailabilityCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.pushingToProviderDetailVC()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80);
    }
}
extension SearchViewController{
    @objc func pushingToProviderDetailVC(){
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIDs.ServiceProviderDetailVC) as? ServiceProviderDetailVC{
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
}
