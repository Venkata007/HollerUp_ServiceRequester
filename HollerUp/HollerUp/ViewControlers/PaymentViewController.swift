//
//  PaymentViewController.swift
//  HollerUp
//
//  Created by Vamsi on 10/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import Stripe

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet var viewsInView: [UIView]!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var paymentCardView: UIView!
    @IBOutlet weak var billingAddressTF: UITextField!
    @IBOutlet weak var billingCityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipcodeTF: UITextField!
    @IBOutlet weak var billingCountryTF: UITextField!
    
    let paymentTextField = STPPaymentCardTextField()
    
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
        // Programatically written for Stripe Text Field
        paymentTextField.frame = CGRect(x: 0, y: 0, width: self.paymentCardView.frame.width, height: self.paymentCardView.frame.height)
        paymentTextField.delegate = self
        paymentTextField.borderColor = UIColor.clear
        paymentTextField.backgroundColor = UIColor.clear
        paymentTextField.font = UIFont.appFont(.Regular)
        self.paymentCardView.addSubview(paymentTextField)
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
extension PaymentViewController : STPPaymentCardTextFieldDelegate{
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        print("Card number: \(String(describing: paymentTextField.cardParams.number)) Exp Month: \(paymentTextField.cardParams.expMonth) Exp Year: \(paymentTextField.cardParams.expYear) CVC: \(String(describing: paymentTextField.cardParams.cvc))")
    }
    // MARK : - Creating Payment Token
    func creatingPaymentToken(){
        let cardParams = STPCardParams()
        cardParams.number                           = paymentTextField.cardParams.number
        cardParams.expMonth                       = paymentTextField.cardParams.expMonth
        cardParams.expYear                           = paymentTextField.cardParams.expYear
        cardParams.cvc                                   = paymentTextField.cardParams.cvc
        cardParams.name                               = fullNameTF.text
        cardParams.address.line1                 = billingAddressTF.text
        cardParams.address.state                 = stateTF.text
        cardParams.address.postalCode    = zipcodeTF.text
        cardParams.address.country            = billingCountryTF.text
        cardParams.address.city                   = billingCityTF.text
        STPAPIClient .shared().createToken(withCard: cardParams) { (token, error) in
            if error != nil  {
                print(error?.localizedDescription ?? String())
                TheGlobalPoolManager.showToastView((error?.localizedDescription)!)
            }else{
                print(token!)
            }
        }
    }
}
