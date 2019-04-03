//
//  CalendarViewController.swift
//  HollerUp
//
//  Created by Vamsi on 08/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EventKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarViewInView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector:#selector(CalendarViewController.addEventCalendar(notification:)), name: Notification.Name("AddButton_Calendar"), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(CalendarViewController.synchCalendar(notification:)), name: Notification.Name("SyncButton_Calendar"), object: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: TableViewCellIdentifiers.AppointmentCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.AppointmentCell)
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        self.tableView.tableFooterView = UIView()
        self.fetchEventsFromCalendar()
        self.addEventToCalendar(title: "Lunch Box", description: "Remember to me pick at 06:00 PM", startDate: Date(), endDate: Date())
    }
     //MARK:- Adding Event to Apple Calendar
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
    func fetchEventsFromCalendar() -> Void {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        switch (status) {
        case .notDetermined:
            requestAccessToCalendar()
        case .authorized:
            self.fetchEventsFromCalendar(calendarTitle: "Calendar")
            break
        case .restricted, .denied: break
        }
    }
    func requestAccessToCalendar() {
        eventStore.requestAccess(to: EKEntityType.event) { (accessGranted, error) in
            self.fetchEventsFromCalendar(calendarTitle: "Calendar")
        }
    }
    // MARK: Fetech Events from Calendar
    func fetchEventsFromCalendar(calendarTitle: String) -> Void {
        //PGAEventsCalendar
         let calendars = eventStore.calendars(for: .event)
        for calendar:EKCalendar in calendars {
            if calendar.title == calendarTitle {
                let selectedCalendar = calendar
                let startDate = NSDate()
                let endDate = NSDate(timeIntervalSinceNow: 60*60*24*180)
                let predicate = eventStore.predicateForEvents(withStart: startDate as Date, end: endDate as Date, calendars: [selectedCalendar])
                let events = eventStore.events(matching: predicate) as [EKEvent]
                print("Events: \(events)")
                for event in events {
                    print("Event Title : \(event.title!) Event ID: \(event.eventIdentifier!)")
                }
            }
        }
    }
    //MARK:- IB Action Outlets
}
extension CalendarViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            if cell == nil{
                cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
            }
            cell?.textLabel?.text = "Upcoming Appointments"
            cell?.textLabel?.font = UIFont.appFont(.Bold, size: 20)
            cell?.textLabel?.textColor = .themeColor
            cell?.selectionStyle = .none
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.AppointmentCell) as! AppointmentCell
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
           self.UpcomingDetailsViewPopUpView()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return UIDevice.isPhone() ? 30 : 60
        }
        return  UIDevice.isPhone() ? 100 : 120
    }
}
extension CalendarViewController{
    //MARK: - Upcoming Details View
    @objc func UpcomingDetailsViewPopUpView(){
        let viewCon = UpcomingDetailsView(nibName: "UpcomingDetailsView", bundle: nil)
        self.presentPopupViewController(viewCon, animationType: MJPopupViewAnimationSlideTopTop)
    }
    @objc func addEventCalendar(notification: Notification){
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIDs.AddCalendarEvent) as? AddCalendarEvent{
            //viewCon.hidesBottomBarWhenPushed = true
            self.present(viewCon, animated: true, completion: nil)
        }
    }
    @objc func synchCalendar(notification: Notification){
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIDs.SynchCalendarVC) as? SynchCalendarVC{
            //viewCon.hidesBottomBarWhenPushed = true
            self.present(viewCon, animated: true, completion: nil)
        }
    }
}
