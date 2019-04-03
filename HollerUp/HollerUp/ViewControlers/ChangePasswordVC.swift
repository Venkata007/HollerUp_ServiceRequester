//
//  ChangePasswordVC.swift
//  HollerUp
//
//  Created by Vamsi on 22/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var confirmPasswordHideBtn: UIButton!
    @IBOutlet var viewsInView: [UIView]!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    @IBAction func confirmPasswordHideBtn(_ sender: UIButton) {
        if sender.tag == 0{
            sender.setTitle("Show", for: .normal)
            self.confirmPasswordTF.isSecureTextEntry = false
            sender.tag = 1
        }else{
            sender.setTitle("Hide", for: .normal)
            self.confirmPasswordTF.isSecureTextEntry = true
            sender.tag = 0
        }
    }
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
    @IBAction func submitBtn(_ sender: Any) {
        if validate(){
            
        }
    }
}
extension ChangePasswordVC{
    //MARK:- Validation
    func validate() -> Bool{
        if (self.newPasswordTF.text?.isEmpty)! || !(self.newPasswordTF.text?.isPasswordValid)!{
            TheGlobalPoolManager.showToastView(ToastMessages.Invalid_Password)
            return false
        }else if (self.confirmPasswordTF.text?.isEmpty)! || !(self.confirmPasswordTF.text?.isPasswordValid)!{
            TheGlobalPoolManager.showToastView(ToastMessages.Invalid_Password)
            return false
        }else if newPasswordTF.text != confirmPasswordTF.text{
            TheGlobalPoolManager.showToastView(ToastMessages.Password_Missmatch)
            return false
        }
        return true
    }
}
