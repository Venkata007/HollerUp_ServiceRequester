//
//  AppointmnetsViewController.swift
//  HollerUp
//
//  Created by Vamsi on 08/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class AppointmnetsViewController: UIViewController,PickerViewDelegate  {
    @IBOutlet weak var headerTitleLbl: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completedViewInView: UIView!
    @IBOutlet weak var totalCallsBgView: UIView!
    @IBOutlet weak var datesBgView: UIView!
    @IBOutlet weak var completedViewInViewHeight: NSLayoutConstraint!
    @IBOutlet weak var fromDatePickerBtn: UIButton!
    @IBOutlet weak var toDatePickerPtn: UIButton!
    
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
        self.tableView.register(UINib(nibName: TableViewCellIdentifiers.AppointmentCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.AppointmentCell)
        self.tableView.register(UINib(nibName: TableViewCellIdentifiers.NewAppointmentCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.NewAppointmentCell)
          self.tableView.register(UINib(nibName: TableViewCellIdentifiers.CompletedCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.CompletedCell)
        NotificationCenter.default.addObserver(self, selector: #selector(AppointmnetsViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("Reject_CancelButton"), object: nil)
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        ez.runThisInMainThread {
            self.completedViewInViewHeight.constant = 0
            self.completedViewInView.isHidden = true
        }
        TheGlobalPoolManager.cornerAndBorder(fromDatePickerBtn, cornerRadius: 8, borderWidth: 1, borderColor: .lightGray)
        TheGlobalPoolManager.cornerAndBorder(toDatePickerPtn, cornerRadius: 8, borderWidth: 1, borderColor: .lightGray)
        self.totalCallsBgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
        self.datesBgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
        self.tableView.tableFooterView = UIView()
        self.segmentControl.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.appFont(.Bold)],for: .normal)
    }
    //MARK:- IB Action Outlets
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.completedViewInViewHeight.constant = 0
            self.completedViewInView.isHidden = true
            tableView.reloadData()
        case 1:
            self.completedViewInViewHeight.constant = 0
            self.completedViewInView.isHidden = true
            tableView.reloadData()
        case 2:
            self.completedViewInViewHeight.constant = UIDevice.isPhone() ? 95 :120
            self.completedViewInView.isHidden = false
            tableView.reloadData()
        default:
            break
        }
    }
}
extension AppointmnetsViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.NewAppointmentCell) as! NewAppointmentCell
            cell.rejectBtn.tag = indexPath.row
            cell.rejectBtn.addTarget(self, action: #selector(rejectAppointmentPopUpView), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.AppointmentCell) as! AppointmentCell
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.CompletedCell) as! CompletedCell
            cell.selectionStyle = .none
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentControl.selectedSegmentIndex == 1{
            //UpcomingDetailsView
            self.UpcomingDetailsViewPopUpView()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            return UITableViewAutomaticDimension
        case 2:
            return 150
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
            return UITableViewAutomaticDimension
        case 2:
            return UIDevice.isPhone() ? 150 : 200
        default:
            break
        }
        return UITableViewAutomaticDimension
    }
}
extension AppointmnetsViewController{
    //MARK: - Reject Appointmnet Pop Up
    @objc func rejectAppointmentPopUpView(){
        let viewCon = RejectPopUpOptions(nibName: "RejectPopUpOptions", bundle: nil)
        self.presentPopupViewController(viewCon, animationType: MJPopupViewAnimationFade)
    }
    //MARK: - Upcoming Details View
    @objc func UpcomingDetailsViewPopUpView(){
        let viewCon = UpcomingDetailsView(nibName: "UpcomingDetailsView", bundle: nil)
        self.presentPopupViewController(viewCon, animationType: MJPopupViewAnimationFade)
    }
    @objc func methodOfReceivedNotification(notification: Notification){
        self.dismissPopupViewControllerWithanimationType(MJPopupViewAnimationFade)
    }
}
extension AppointmnetsViewController{
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
