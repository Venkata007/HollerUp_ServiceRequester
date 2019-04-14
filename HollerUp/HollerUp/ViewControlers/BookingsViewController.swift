//
//  BookingsViewController.swift
//  HollerUp
//
//  Created by Vamsi on 08/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class BookingsViewController: UIViewController,PickerViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var datesBgView: UIView!
    @IBOutlet weak var fromDatePickerBtn: UIButton!
    @IBOutlet weak var toDatePickerPtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var datesBgViewHeight: NSLayoutConstraint!
    
    var datePicker:PickerView!
    var selectedBtn : String!
    let date = Date()
    var startTime : String!
    var endTime : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: TableViewCellIdentifiers.CurrentBookingCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.CurrentBookingCell)
        self.tableView.register(UINib(nibName: TableViewCellIdentifiers.BookingsHistoryCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.BookingsHistoryCell)
        self.datesBgViewHeight.constant = 0
        self.datesBgView.isHidden = true
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        self.datesBgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
        TheGlobalPoolManager.cornerAndBorder(fromDatePickerBtn, cornerRadius: 8, borderWidth: 1, borderColor: .lightGray)
        TheGlobalPoolManager.cornerAndBorder(toDatePickerPtn, cornerRadius: 8, borderWidth: 1, borderColor: .lightGray)
        self.segmentControl.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.appFont(.Bold)],for: .normal)
    }
    //MARK:- IB Action Outlets
    @IBAction func shareBtn(_ sender: UIButton) {
    }
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.datesBgViewHeight.constant = 0
            self.datesBgView.isHidden = true
            tableView.reloadData()
        case 1:
            self.datesBgViewHeight.constant = 35
            self.datesBgView.isHidden = false
            tableView.reloadData()
        default:
            break
        }
    }
}
extension BookingsViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.CurrentBookingCell) as! CurrentBookingCell
            cell.selectionStyle = .none
            if indexPath.row % 2 == 0{
                cell.statusBtn.setTitle("APPOINTMENT - PENDING", for: .normal)
                cell.statusBtn.backgroundColor = #colorLiteral(red: 1, green: 0.8330218792, blue: 0.1556026936, alpha: 1)
            }else{
                cell.statusBtn.setTitle("CALL - CONFIRMED", for: .normal)
                cell.statusBtn.backgroundColor = #colorLiteral(red: 0, green: 0.7215686275, blue: 0.5803921569, alpha: 1)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.BookingsHistoryCell) as! BookingsHistoryCell
            cell.selectionStyle = .none
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            return 120
        default:
            break
        }
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            return 120
        default:
            break
        }
        return UITableViewAutomaticDimension
    }
}
extension BookingsViewController{
    @IBAction func toDatePickerBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        selectedBtn = "Start"
        self.datePickerView("From")
    }
    @IBAction func fromDatePickerBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        selectedBtn = "End"
        self.datePickerView("To")
    }
    func datePickerView( _ btnName : String){
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
        self.datePicker.nameLbl = btnName
        self.datePicker.show(attachToView: self.view)
    }
    //MARK : - Gertting Age  based on DOB
    func pickerViewDidSelectDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        dateFormatter.timeZone = NSTimeZone.local
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
