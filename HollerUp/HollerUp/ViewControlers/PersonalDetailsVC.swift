//
//  PersonalDetailsVC.swift
//  HollerUp
//
//  Created by Vamsi on 28/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import PopOverMenu

class PersonalDetailsVC: UIViewController,PickerViewDelegate,UIAdaptivePresentationControllerDelegate {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var profileDesTextView: UITextView!
    @IBOutlet weak var enterFirstNameTF: UITextField!
    @IBOutlet weak var enterLastNameTF: UITextField!
    @IBOutlet var genderRadioBtns: [UIButton]!
    @IBOutlet weak var dateOfBirthBtn: ButtonIconRight!
    @IBOutlet weak var mobileNumTF: UITextField!
    @IBOutlet weak var mobileNumVerifyBtn: UIButton!
    @IBOutlet weak var landlineNumTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailVerifyBtn: UIButton!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var cityDropDownBtn: UIButton!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var countryDropDownBtn: UIButton!
    @IBOutlet weak var cityViewInView: UIView!
    @IBOutlet weak var countryViewInView: UIView!
    @IBOutlet weak var zipCodeTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    var datePicker:PickerView!
    var selectedBtn : String!
    let date = Date()
    let popOverViewController = PopOverViewController.instantiate()
    var cities:[String] = ["Hydrebad","Banglore","Ahmedabad","Pune"]
    var countries:[String] = ["India","America","Australia","England"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ez.runThisInMainThread {
            self.updateUI()
        }
        for btn in genderRadioBtns{
            if btn.tag == 0{
                self .genderRadioBtns(btn)
            }
        }
    }
    //MARK:- Update UI
    func updateUI(){
        self.enterFirstNameTF.setBottomBorder()
        self.enterLastNameTF.setBottomBorder()
        self.emailTF.setBottomBorder()
        self.addressTF.setBottomBorder()
        self.addressTF.setBottomBorder()
        self.zipCodeTF.setBottomBorder()
        TheGlobalPoolManager.cornerAndBorder(cityViewInView, cornerRadius: 8, borderWidth: 1, borderColor: .themeColor)
        TheGlobalPoolManager.cornerAndBorder(countryViewInView, cornerRadius: 8, borderWidth: 1, borderColor: .themeColor)
        TheGlobalPoolManager.cornerAndBorder(dateOfBirthBtn, cornerRadius: 8, borderWidth: 1, borderColor: .themeColor)
           self.profileImgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
           self.saveBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
    }
    //MARK:- IB Action Outlets
    @IBAction func genderRadioBtns(_ sender: UIButton) {
        for button in genderRadioBtns {
            if button == sender {
                button.isSelected = true
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                if button.tag == 0{
                    button.setImage(#imageLiteral(resourceName: "Radio_On"), for: .normal)
                }
                else  if button.tag == 1{
                    button.setImage(#imageLiteral(resourceName: "Radio_On"), for: .normal)
                }
            }
            else{
                button.isSelected = false
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setImage(#imageLiteral(resourceName: "Radio_Off"), for: .normal)
            }
        }
    }
    @IBAction func mobileNumVerifyBtn(_ sender: UIButton) {
    }
    @IBAction func emailVerifyBtn(_ sender: UIButton) {
    }
    @IBAction func cityDropDownBtn(_ sender: UIButton) {
        sender.tag = 0
        self.popOverMenu(sender, array: self.cities)
    }
    @IBAction func countryDropDownBtn(_ sender: UIButton) {
        sender.tag = 1
        self.popOverMenu(sender, array: self.countries)
    }
    @IBAction func saveBtn(_ sender: UIButton) {
    }
}
extension PersonalDetailsVC{
    @IBAction func dateOfBirthBtn(_ sender: ButtonIconRight) {
        self.view.endEditing(true)
        self.datePickerView()
    }
    func datePickerView(){
        self.datePicker = nil
        self.datePicker = PickerView(frame: self.view.frame)
        self.datePicker.tapToDismiss = true
        self.datePicker.datePickerMode = .time
        self.datePicker.showBlur = true
        self.datePicker.datePickerStartDate = self.date
        self.datePicker.btnFontColour = UIColor.white
        self.datePicker.btnColour = .themeColor
        self.datePicker.showCornerRadius = false
        self.datePicker.delegate = self
        self.datePicker.show(attachToView: self.view)
    }
    //MARK : - Gertting Age  based on DOB
    func pickerViewDidSelectDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        dateFormatter.timeZone = NSTimeZone.init(abbreviation: "UTC")! as TimeZone
        let strDate = dateFormatter.string(from: (date))
        print(strDate)
        self.dateOfBirthBtn.setTitle(strDate, for: .normal)
    }
}
extension PersonalDetailsVC{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    func popOverMenu(_ sender : UIButton , array : [String]){
        //POP MENU
        self.popOverViewController.setTitles(array)
        self.popOverViewController.setSeparatorStyle(UITableViewCellSeparatorStyle.singleLine)
        self.popOverViewController.popoverPresentationController?.sourceView = sender
        self.popOverViewController.popoverPresentationController?.sourceRect = sender.bounds
        self.popOverViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        self.popOverViewController.preferredContentSize = CGSize(width: 180, height: 120)
        self.popOverViewController.presentationController?.delegate = self
        ez.runThisInMainThread {
            self.popOverViewController.completionHandler = { selectRow in
                print(array[selectRow])
                if sender.tag == 0{
                    self.cityTF.text = array[selectRow]
                }else{
                    self.countryTF.text = array[selectRow]
                }
            }
        }
        self.present(self.popOverViewController, animated: true, completion: nil)
    }
}
