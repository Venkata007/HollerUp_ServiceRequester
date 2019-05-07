//
//  SignUpViewController.swift
//  HollerUp
//
//  Created by Vamsi on 08/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class SignUpViewController: UIViewController {

    @IBOutlet var viewInViews: [UIView]!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var emailIDTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        for view in viewInViews{
            view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
        }
        self.continueBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
    @IBAction func continueBtn(_ sender: UIButton) {
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIDs.PaymentViewController) as? PaymentViewController{
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
}
extension SignUpViewController {
    //MARK:- Validation
    func validate() -> Bool{
        if (self.firstNameTF.text?.isEmpty)!{
            TheGlobalPoolManager.showToastView(ToastMessages.Invalid_FirstName)
            return false
        }else if (self.lastNameTF.text?.isEmpty)!{
            TheGlobalPoolManager.showToastView(ToastMessages.Invalid_LastName)
            return false
        }else if (self.mobileNumberTF.text?.isEmpty)!{
            TheGlobalPoolManager.showToastView(ToastMessages.Invalid_Number)
            return false
        }else if (self.emailIDTF.text?.isEmpty)!{
            TheGlobalPoolManager.showToastView(ToastMessages.Invalid_Email)
            return false
        }else if !TheGlobalPoolManager.isValidEmail(testStr: emailIDTF.text!){
            TheGlobalPoolManager.showToastView(ToastMessages.Email_Address_Is_Not_Valid)
            return false
        }
        return true
    }
}
