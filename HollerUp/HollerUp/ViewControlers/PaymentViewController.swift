//
//  PaymentViewController.swift
//  HollerUp
//
//  Created by Vamsi on 10/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet var viewsInView: [UIView]!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        for view in viewsInView{
            view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
        }
        self.saveBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
    }
    //MARK:- IB Action Outlets
    @IBAction func skipBtn(_ sender: UIButton) {
        self.pushingToDashBoardVC()
    }
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
    @IBAction func saveBtn(_ sender: UIButton) {
        self.pushingToDashBoardVC()
    }
}
extension PaymentViewController{
    //MARK: - Pushing the DashBoard View Controller
    func pushingToDashBoardVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: ViewControllerIDs.TabBarController) as! TabBarController
        controller.selectedIndex = 1
        DispatchQueue.main.async {
            if let unselectedImage = UIImage(named: "HollerUp-Icon-Deactive"), let selectedImage = UIImage(named: "HollerUp-Icon-Active") {
                controller.addCenterButton(unselectedImage: unselectedImage, selectedImage: selectedImage)
            }
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
