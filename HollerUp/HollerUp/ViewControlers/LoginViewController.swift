//
//  LoginViewController.swift
//  HollerUp
//
//  Created by Vamsi on 22/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var viewInView: UIView!
    @IBOutlet weak var emailViewInView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordViewInView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var needHelpBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.emailTF.text = "vamsi@gmail.com"
        self.passwordTF.text = "123456"
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        self.viewInView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 15)
         self.emailViewInView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
         self.passwordViewInView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
         self.signInBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
    }
    //MARK:- IB Action Outlets
    @IBAction func forgotPasswordBtn(_ sender: Any) {
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIDs.ForgotPasswordVC) as? ForgotPasswordVC{
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    @IBAction func needHelpBtn(_ sender: UIButton) {
    }
    @IBAction func signInBtn(_ sender: UIButton) {
        if validate(){
            self.pushingToDashBoardVC()
        }
    }
    @IBAction func signUpBtn(_ sender: UIButton) {
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIDs.SignUpViewController) as? SignUpViewController{
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
}
extension LoginViewController{
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
    //MARK:- Validation
    func validate() -> Bool{
        if (self.emailTF.text?.isEmpty)!{
            TheGlobalPoolManager.showToastView(ToastMessages.Invalid_Email)
            return false
        }else if (self.passwordTF.text?.isEmpty)!{
            TheGlobalPoolManager.showToastView(ToastMessages.Invalid_Password)
            return false
        }
        return true
    }
}
