//
//  EditProfileViewController.swift
//  HollerUp
//
//  Created by Vamsi on 28/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class EditProfileViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var personalInfoView: UIView!
    @IBOutlet weak var professionalInfoView: UIView!
    @IBOutlet weak var paymentInfoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        self.segmentControl.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.appFont(.Medium, size: UIDevice.isPhone() ? 16 : 18)],for: .normal)
        self.segmentControl(segmentControl)
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.dismissVC(completion: nil)
    }
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.personalInfoView.isHidden = false
            self.professionalInfoView.isHidden = true
            self.paymentInfoView.isHidden = true
        case 1:
            self.personalInfoView.isHidden = true
            self.professionalInfoView.isHidden = false
            self.paymentInfoView.isHidden = true
        case 2:
            self.personalInfoView.isHidden = true
            self.professionalInfoView.isHidden = true
            self.paymentInfoView.isHidden = false
        default:
            break
        }
    }
}
