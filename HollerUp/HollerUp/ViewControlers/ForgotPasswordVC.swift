//
//  ForgotPasswordVC.swift
//  HollerUp
//
//  Created by Vamsi on 22/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ForgotPasswordVC: UIViewController,OTPTextFieldDelegate {
    @IBOutlet weak var mobileNumberViewInView: UIView!
    @IBOutlet weak var emailIDViewInView: UIView!
    @IBOutlet weak var mobileNumTF: UITextField!
    @IBOutlet weak var emailIDTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var orLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    //Enter OTP View
    @IBOutlet weak var OTPBgView: UIView!
    @IBOutlet weak var OTPViewInView: UIView!
    @IBOutlet weak var otpSuccessLbl: UILabel!
    @IBOutlet var OTP1: OTPTextField!
    @IBOutlet var OTP2: OTPTextField!
    @IBOutlet var OTP3: OTPTextField!
    @IBOutlet var OTP4: OTPTextField!
    @IBOutlet weak var resendOtpBtn: UIButton!
    @IBOutlet weak var otpContinueBtn: UIButton!
    @IBOutlet weak var otpCancelBtn: UIButton!
    @IBOutlet weak var otpsBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        self.OTPBgView.isHidden = true
     self.emailIDViewInView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
        self.mobileNumberViewInView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
        self.submitBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
        self.orLbl.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : self.orLbl.h / 2)
        self.OTPViewInView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
        ez.runThisInMainThread {
            TheGlobalPoolManager.cornerAndBorder(self.otpsBgView, cornerRadius: 10, borderWidth: 0, borderColor: .clear)
            TheGlobalPoolManager.cornerRadiusForParticularCornerr(self.OTP1, corners: [.topLeft,.bottomLeft], size: CGSize(width: 10, height: 0))
            TheGlobalPoolManager.cornerRadiusForParticularCornerr(self.OTP4, corners: [.topRight,.bottomRight], size: CGSize(width: 10, height: 0))
             TheGlobalPoolManager.cornerRadiusForParticularCornerr(self.otpCancelBtn, corners: [.bottomLeft], size: CGSize(width: 10, height: 0))
            TheGlobalPoolManager.cornerRadiusForParticularCornerr(self.otpContinueBtn, corners: [.bottomRight], size: CGSize(width: 10, height: 0))
        }
        OTP1.delegate = self
        OTP2.delegate = self
        OTP3.delegate = self
        OTP4.delegate = self
        
        OTP1.addTarget(self, action: #selector(ForgotPasswordVC.textFieldDidChange(_:)), for: .editingChanged)
        OTP2.addTarget(self, action: #selector(ForgotPasswordVC.textFieldDidChange(_:)), for: .editingChanged)
        OTP3.addTarget(self, action: #selector(ForgotPasswordVC.textFieldDidChange(_:)), for: .editingChanged)
        OTP4.addTarget(self, action: #selector(ForgotPasswordVC.textFieldDidChange(_:)), for: .editingChanged)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.OTPBgView {
            self.OTPBgView.isHidden = true
        }
    }
    //MARK:- IB Action Outlets
    @IBAction func submitBtn(_ sender: UIButton) {
        self.OTPBgView.isHidden = false
    }
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
    @IBAction func resendOtpBtn(_ sender: UIButton) {
    }
    @IBAction func otpContinueBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        if validateOTP().1.length == 4{
            print(validateOTP().1)
        }else{
            TheGlobalPoolManager.showToastView("Enter 4-digit OTP")
        }
    }
    @IBAction func otpCancelButton(_ sender: UIButton) {
        self.OTPBgView.isHidden = true
    }
}
//MARK :- TextField Delegates
extension ForgotPasswordVC : UITextFieldDelegate{
    @objc func textFieldDidChange(_ textField: UITextField){
        let text = textField.text
        if text?.utf16.count==1{
            self.otpContinueBtn.isEnabled = self.validateOTP().0
            switch textField{
            case OTP1:
                OTP2.becomeFirstResponder()
            case OTP2:
                OTP3.becomeFirstResponder()
            case OTP3:
                OTP4.becomeFirstResponder()
            case OTP4:
                OTP4.resignFirstResponder()
                break
            default:
                break
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField is OTPTextField{
            textField.text = ""
        }
        UIView.beginAnimations(nil, context: nil)
        UIView.animate(withDuration: 0.25) {
            self.otpContinueBtn.isEnabled = self.validateOTP().0
        }
        UIView.commitAnimations()
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //self.view.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.beginAnimations(nil, context: nil)
        UIView.animate(withDuration: 0.25) {
        }
        UIView.commitAnimations()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if string == "\n"{
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    func didPressBackspace(textField : OTPTextField){
        let text = textField.text
        if text?.utf16.count == 0{
            switch textField{
            case OTP4:
                OTP3.becomeFirstResponder()
            case OTP3:
                OTP2.becomeFirstResponder()
            case OTP2:
                OTP1.becomeFirstResponder()
            case OTP1: break
            default:
                break
            }
        }
    }
}
//MARK :- Validation
extension ForgotPasswordVC{
    func validateOTP() -> (Bool,String){
        let otpTF = [OTP1,OTP2,OTP3,OTP4]
        var validation = true
        var otpString = ""
        for otp in otpTF{
            if (otp?.text?.isEmpty)!{
                validation = false
                break
            }
            otpString = otpString + (otp?.text)!
        }
        return (validation,otpString)
    }
}
//MARK:- Override Textfield Delegate
protocol OTPTextFieldDelegate : UITextFieldDelegate {
    func didPressBackspace(textField : OTPTextField)
}
//MARK :- Override TextField
class OTPTextField:UITextField{
    override func deleteBackward() {
        super.deleteBackward()
        if let pinDelegate = self.delegate as? OTPTextFieldDelegate {
            pinDelegate.didPressBackspace(textField: self)
        }
    }
    override func tintColorDidChange() {
        super.tintColorDidChange()
        self.tintColor = UIColor.white
    }
    override func caretRect(for position: UITextPosition) -> CGRect {
        var rect = super.caretRect(for: position)
        rect = CGRect(x: (self.bounds.width-2)/2, y: (self.bounds.height-25)/2, width: 2, height: 25)
        return rect
    }
}
