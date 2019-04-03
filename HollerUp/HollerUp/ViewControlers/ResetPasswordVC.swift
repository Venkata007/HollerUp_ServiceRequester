//
//  ResetPasswordVC.swift
//  HollerUp
//
//  Created by Vamsi on 22/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ResetPasswordVC: UIViewController {

    @IBOutlet var viewsInView: [UIView]!
    @IBOutlet weak var currentPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmpasswordTF: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var currentpasswordHideBtn: UIButton!
    @IBOutlet weak var confirmPasswordHideBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        for view in viewsInView{
            view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
        }
        self.submitBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
    }
    //MARK:- IB Action Outlets
    @IBAction func submitBtn(_ sender: UIButton) {
        if validate(){
            
        }
    }
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
    @IBAction func currentPasswordHideBtn(_ sender: UIButton) {
        if sender.tag == 0{
            sender.setTitle("Show", for: .normal)
            self.currentPasswordTF.isSecureTextEntry = false
            sender.tag = 1
        }else{
            sender.setTitle("Hide", for: .normal)
            self.currentPasswordTF.isSecureTextEntry = true
            sender.tag = 0
        }
    }
    @IBAction func confirmPasswordHideBtn(_ sender: UIButton) {
        if sender.tag == 0{
            sender.setTitle("Show", for: .normal)
            self.confirmpasswordTF.isSecureTextEntry = false
            sender.tag = 1
        }else{
            sender.setTitle("Hide", for: .normal)
            self.confirmpasswordTF.isSecureTextEntry = true
            sender.tag = 0
        }
    }
}
extension ResetPasswordVC{
    //MARK:- Validation
    func validate() -> Bool{
        if (self.currentPasswordTF.text?.isEmpty)!{
            TheGlobalPoolManager.showToastView(ToastMessages.Invalid_Current_Password)
            return false
        }else if (self.newPasswordTF.text?.isEmpty)! || !(self.newPasswordTF.text?.isPasswordValid)!{
            TheGlobalPoolManager.showToastView(ToastMessages.Invalid_Password)
            return false
        }else if (self.confirmpasswordTF.text?.isEmpty)! || !(self.confirmpasswordTF.text?.isPasswordValid)!{
            TheGlobalPoolManager.showToastView(ToastMessages.Invalid_Password)
            return false
        }else if newPasswordTF.text != confirmpasswordTF.text{
            TheGlobalPoolManager.showToastView(ToastMessages.Password_Missmatch)
            return false
        }
        return true
    }
}
