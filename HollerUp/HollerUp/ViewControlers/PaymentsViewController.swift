//
//  PaymentsViewController.swift
//  HollerUp
//
//  Created by Vamsi on 08/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class PaymentsViewController: UIViewController,PickerViewDelegate{

    @IBOutlet weak var headerTitleLbl: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewStatementViewInView: UIView!
    @IBOutlet weak var totalEarningsBgView: UIView!
    @IBOutlet weak var datesBgView: UIView!
    @IBOutlet weak var fromDatePickerBtn: UIButton!
    @IBOutlet weak var toDatePickerPtn: UIButton!
    @IBOutlet weak var invoiceBtn: UIButton!
    
    // Unbilled Payment View
    @IBOutlet weak var unbilledBgView: UIView!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var totalAmountTF: UITextField!
    @IBOutlet weak var enterAmountTF: UITextField!
    @IBOutlet var radioBtns: [UIButton]!
    @IBOutlet weak var transferBtn: UIButton!
    
    
    var datePicker:PickerView!
    var selectedBtn : String!
    let date = Date()
    var startTime : String!
    var endTime : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: TableViewCellIdentifiers.PaymentCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.PaymentCell)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        TheGlobalPoolManager.cornerAndBorder(totalAmountTF, cornerRadius: 8, borderWidth: 1, borderColor: .themeColor)
        TheGlobalPoolManager.cornerAndBorder(enterAmountTF, cornerRadius: 8, borderWidth: 1, borderColor: .themeColor)
        TheGlobalPoolManager.cornerAndBorder(fromDatePickerBtn, cornerRadius: 8, borderWidth: 1, borderColor: .lightGray)
        TheGlobalPoolManager.cornerAndBorder(toDatePickerPtn, cornerRadius: 8, borderWidth: 1, borderColor: .lightGray)
        ez.runThisInMainThread {
            self.totalEarningsBgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
            self.datesBgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
            self.transferBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
        }
        self.tableView.tableFooterView = UIView()
        self.segmentControl.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.appFont(.Bold)],for: .normal)
        for btn in radioBtns{
            if btn.tag == 0{
                self .radioBtns(btn)
            }
        }
    }
    //MARK:- IB Action Outlets
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.tableView.isHidden = true
            self.unbilledBgView.isHidden = false
            break
        case 1:
            self.tableView.isHidden = false
            self.unbilledBgView.isHidden = true
            self.tableView.reloadData()
        default:
            break
        }
    }
    @IBAction func invoiceBtn(_ sender: UIButton) {
    }
    @IBAction func radioBtns(_ sender: UIButton) {
        for button in radioBtns {
            if button == sender {
                button.isSelected = true
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                if button.tag == 0{
                    button.setImage(#imageLiteral(resourceName: "Radio_On"), for: .normal)
                    totalAmountTF.isUserInteractionEnabled = true
                    enterAmountTF.isUserInteractionEnabled = false
                }
                else  if button.tag == 1{
                    button.setImage(#imageLiteral(resourceName: "Radio_On"), for: .normal)
                    totalAmountTF.isUserInteractionEnabled = false
                    enterAmountTF.isUserInteractionEnabled = true
                }
            }
            else{
                button.isSelected = false
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setImage(#imageLiteral(resourceName: "Radio_Off"), for: .normal)
            }
        }
    }
    @IBAction func transferBtn(_ sender: UIButton) {
    }
}
extension PaymentsViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.PaymentCell) as! PaymentCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UIDevice.isPhone() ? 100 : 120
    }
}
extension PaymentsViewController{
    @IBAction func fromDatePickerBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        selectedBtn = "Start"
        self.datePickerView()
    }
    @IBAction func toDatePickerBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        selectedBtn = "End"
        self.datePickerView()
    }
    func datePickerView(){
        self.datePicker = nil
        self.datePicker = PickerView(frame: self.view.frame)
        self.datePicker.tapToDismiss = true
        self.datePicker.datePickerMode = .date
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
        if selectedBtn == "Start"{
            fromDatePickerBtn.setTitle(strDate, for: .normal)
            startTime = strDate
        }
        else{
            toDatePickerPtn.setTitle(strDate, for: .normal)
            endTime = strDate
        }
    }
}
