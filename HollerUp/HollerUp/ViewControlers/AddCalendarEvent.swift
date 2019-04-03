//
//  AddCalendarEvent.swift
//  HollerUp
//
//  Created by Vamsi on 27/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import PopOverMenu


class AddCalendarEvent: UIViewController,UIAdaptivePresentationControllerDelegate,PickerViewDelegate {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var emailHeaderLbl: UILabel!
    @IBOutlet weak var eventNameTF: UITextField!
    @IBOutlet weak var fromDateTF: UITextField!
    @IBOutlet weak var fromTimeTF: UITextField!
    @IBOutlet weak var toDateTF: UITextField!
    @IBOutlet weak var toTimeTF: UITextField!
    @IBOutlet weak var showAsTF: UITextField!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet var viewsInView: [UIView]!
    @IBOutlet weak var fromDatePickerBtn: UIButton!
    @IBOutlet weak var toDatePickerBtn: UIButton!
    
    let popOverViewController = PopOverViewController.instantiate()
    var titles:[String] = ["Busy","Invisible","None"]
    var datePicker:PickerView!
    var selectedBtn : String!
    let date = Date()
    var startTime : String!
    var endTime : String!
    
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
        self.doneBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.dismissVC(completion: nil)
    }
    @IBAction func dropDownBtn(_ sender: UIButton) {
        //POP MENU
        self.popOverViewController.setTitles(titles)
        self.popOverViewController.setSeparatorStyle(UITableViewCellSeparatorStyle.singleLine)
        self.popOverViewController.popoverPresentationController?.sourceView = sender
        self.popOverViewController.popoverPresentationController?.sourceRect = sender.bounds
        self.popOverViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        self.popOverViewController.preferredContentSize = CGSize(width: 120, height: 120)
        self.popOverViewController.presentationController?.delegate = self
        ez.runThisInMainThread {
            self.popOverViewController.completionHandler = { selectRow in
                print(self.titles[selectRow])
                self.showAsTF.text = self.titles[selectRow]
            }
        }
        self.present(self.popOverViewController, animated: true, completion: nil)
    }
    @IBAction func doneBtn(_ sender: UIButton) {
    }
}
extension AddCalendarEvent{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
extension AddCalendarEvent {
    @IBAction func fromDatePickerBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        selectedBtn = "Start"
        self.datePickerView("From")
    }
    @IBAction func toDatePickerBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        selectedBtn = "End"
        self.datePickerView("To")
    }
    func datePickerView(_ btnName : String){
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
        dateFormatter.dateFormat = "dd'th' MMMM yyyy"
        dateFormatter.timeZone = NSTimeZone.local
        let strDate = dateFormatter.string(from: (date))
        print(strDate)
        
        let dateFormat1 = DateFormatter()
        dateFormat1.dateFormat = "HH:mm"
        dateFormat1.timeZone = NSTimeZone.local
        let stringTime = dateFormat1.string(from: date)
        
        if selectedBtn == "Start"{
            self.fromDateTF.text = strDate
            self.fromTimeTF.text = stringTime
            startTime = strDate
        }
        else{
            self.toDateTF.text = strDate
            self.toTimeTF.text = stringTime
            endTime = strDate
        }
    }
}
