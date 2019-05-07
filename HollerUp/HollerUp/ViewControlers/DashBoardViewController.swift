//
//  DashBoardViewController.swift
//  HollerUp
//
//  Created by Vamsi on 08/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class DashBoardViewController: UIViewController,PickerViewDelegate{

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var viewInView: UIView!
    @IBOutlet weak var subViewInView: UIView!
    @IBOutlet var subViews: [UIView]!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var availabilityTF: UITextField!
    @IBOutlet weak var searchForServiceTF: UITextField!
    @IBOutlet var servicesBtns: [UIButton]!
    
    var datePicker:PickerView!
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        self.searchForServiceTF.delegate = self
        self.locationTF.delegate = self
        self.availabilityTF.delegate = self
        
        self.headerView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 0)
       self.subViewInView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
        ez.runThisInMainThread {
            TheGlobalPoolManager.cornerAndBorder(self.viewInView, cornerRadius: self.viewInView.w / 2, borderWidth: 0, borderColor: .clear)
        }
        for view in subViews{
            view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
        }
        self.searchBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
    }
    //MARK:- IB Action Outlets
    @IBAction func searchBtn(_ sender: UIButton) {
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIDs.SearchViewController) as? SearchViewController{
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    @IBAction func servicesBtns(_ sender: UIButton) {
    }
}
extension DashBoardViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case searchForServiceTF:
            searchForServiceTF.resignFirstResponder()
            return false
        case locationTF:
            locationTF.resignFirstResponder()
            return false
        case availabilityTF:
            availabilityTF.resignFirstResponder()
            self.datePickerView("Availability")
            return false
        default:
            break
        }
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
extension DashBoardViewController {
    func datePickerView( _ btnName : String){
        self.datePicker = nil
        self.datePicker = PickerView(frame: self.view.frame)
        self.datePicker.tapToDismiss = true
        self.datePicker.datePickerMode = .dateAndTime
        self.datePicker.showBlur = true
        self.datePicker.datePickerStartDate = self.date
        self.datePicker.btnFontColour = UIColor.white
        self.datePicker.btnColour = .themeColor
        self.datePicker.showCornerRadius = false
        self.datePicker.delegate = self
        self.datePicker.nameLbl = btnName
        self.datePicker.show(attachToView: self.view)
    }
    //MARK : - Gertting Age  based on DOB
    func pickerViewDidSelectDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY HH:mm"
        dateFormatter.timeZone = NSTimeZone.local
        let strDate = dateFormatter.string(from: (date))
        print(strDate)
        self.availabilityTF.text = strDate
    }
}
