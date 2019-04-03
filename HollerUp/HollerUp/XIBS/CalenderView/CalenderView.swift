//
//  CalenderView.swift
//  Calender
//
//  Created by Hexadots on 14/03/19.
//  Copyright © 2019 Hexadots. All rights reserved.
//

import UIKit
import FSCalendar
import EZSwiftExtensions
class CalenderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var rightArrow: UIButton!
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var yearBtn: UIButton!
    @IBOutlet weak var syncBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var calenderViewInView: FSCalendar!
    
    var leftMonthScroll:UIButton!
    var rightMonthScroll:UIButton!
    
    let acceptedDates = ["2019/03/16","2019/03/19","2019/03/25"]
    let pendingDates = ["2019/03/17","2019/03/22","2019/03/30"]
    let rejectedDates = ["2019/03/03","2019/03/07","2019/03/24"]
    let completedDates = ["2019/03/01","2019/03/05","2019/03/10"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    private func commonInit(){
        Bundle.main.loadNibNamed("CalenderView", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        calenderViewInView.appearance.headerDateFormat = "MMMM"
        calenderViewInView.appearance.headerTitleFont = UIFont.init(name: "Lato-Bold", size: UIDevice.isPhone() ? 16.0 : 20.0)
        calenderViewInView.appearance.selectionColor = #colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.431372549, alpha: 1)
        calenderViewInView.scrollDirection = .horizontal
        calenderViewInView.delegate = self
        calenderViewInView.dataSource = self
        calenderViewInView.allowsSelection = true
        calenderViewInView.headerHeight = 50.0
        let dateString = self.formatter.string(from: calenderViewInView.currentPage).components(separatedBy: "/")
        self.leftArrow.setImage(#imageLiteral(resourceName: "Backward").withColor(.themeColor1), for: .normal)
        self.rightArrow.setImage(#imageLiteral(resourceName: "Farward").withColor(.themeColor1), for: .normal)
        self.yearBtn.setTitle(dateString[0], for: .normal)
        self.leftArrow.addTarget(self, action: #selector(self.buttonActions(_:)), for: .touchUpInside)
        self.yearBtn.addTarget(self, action: #selector(self.buttonActions(_:)), for: .touchUpInside)
        self.rightArrow.addTarget(self, action: #selector(self.buttonActions(_:)), for: .touchUpInside)
        self.syncBtn.addTarget(self, action: #selector(self.buttonActions(_:)), for: .touchUpInside)
        self.searchBtn.addTarget(self, action: #selector(self.buttonActions(_:)), for: .touchUpInside)
        self.addBtn.addTarget(self, action: #selector(self.buttonActions(_:)), for: .touchUpInside)
        self.createMonthScrollButtons()
    }
    
    func createMonthScrollButtons(){
        DispatchQueue.main.async {
            let height = self.calenderViewInView.headerHeight
            print(height)
            self.leftMonthScroll = UIButton(frame: CGRect(x: 0, y: 0, width: height, height: height))
            self.leftMonthScroll.addTarget(self, action: #selector(self.buttonActions(_:)), for: .touchUpInside)
            self.leftMonthScroll.setImage(#imageLiteral(resourceName: "Backward").withColor(.themeColor1), for: .normal)
            self.rightMonthScroll = UIButton(frame: CGRect(x: self.bounds.width-height, y: 0, width: height, height: height))
            self.rightMonthScroll.addTarget(self, action: #selector(self.buttonActions(_:)), for: .touchUpInside)
            print(self.rightMonthScroll)
            self.rightMonthScroll.setImage(#imageLiteral(resourceName: "Farward").withColor(.themeColor1), for: .normal)
            self.calenderViewInView.addSubview(self.leftMonthScroll)
            self.calenderViewInView.addSubview(self.rightMonthScroll)
        }
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    override func layoutIfNeeded(){
        super.layoutIfNeeded()
    }
    
    @objc func buttonActions(_ sender:UIButton){
        switch sender {
        case self.leftArrow:
            self.scrollYearAndMonth(.year, isFutureDate: false)
            break
        case self.yearBtn:
            break
        case self.rightArrow:
            self.scrollYearAndMonth(.year, isFutureDate: true)
            break
        case self.syncBtn:
            NotificationCenter.default.post(name: Notification.Name("SyncButton_Calendar"), object: nil)
            break
        case self.searchBtn:
            break
        case self.addBtn:
             NotificationCenter.default.post(name: Notification.Name("AddButton_Calendar"), object: nil)
            break
        case self.leftMonthScroll:
            self.scrollYearAndMonth(.month, isFutureDate: false)
            break
        case self.rightMonthScroll:
            self.scrollYearAndMonth(.month, isFutureDate: true)
            break
        default:
            break
        }
    }
    
    func scrollYearAndMonth(_ unit:NSCalendar.Unit, isFutureDate:Bool){
        var checkDate:Date = self.calenderViewInView.minimumDate
        var value = -1
        if isFutureDate{
            checkDate = self.calenderViewInView.maximumDate
            value = 1
        }
        let updatedDate = NSCalendar(identifier: .gregorian)?.date(byAdding: unit, value: value, to: self.calenderViewInView.currentPage, options: .matchFirst)
        if let date = updatedDate{
            let compare = date.compare(checkDate)
            switch compare {
            case .orderedAscending:
                if isFutureDate{
                    self.calenderViewInView.setCurrentPage(date, animated: true)
                }
                break
            case .orderedDescending:
                if !isFutureDate{
                    self.calenderViewInView.setCurrentPage(date, animated: true)
                }
                break
            case .orderedSame:
                self.calenderViewInView.setCurrentPage(date, animated: true)
                break
            }
        }
    }
    
}

extension CalenderView : FSCalendarDelegateAppearance, FSCalendarDelegate, FSCalendarDataSource{
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let dateString = self.formatter.string(from: calendar.currentPage).components(separatedBy: "/")
        let yearString = dateString[0]
        self.yearBtn.setTitle(yearString, for: .normal)
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: "2020/12/31")!
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: "2017/01/01")!
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.formatter.string(from: date)
        if acceptedDates.contains(dateString){
            return 1
        }else if rejectedDates.contains(dateString){
            return 1
        }else if completedDates.contains(dateString){
            return 1
        }else if pendingDates.contains(dateString){
            return 1
        }
        return 0
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    // MARK:- FSCalendarDelegateAppearance
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let dateString = self.formatter.string(from: date)
        if acceptedDates.contains(dateString){
            return [#colorLiteral(red: 0, green: 0.7215686275, blue: 0.5803921569, alpha: 1)]
        }else if rejectedDates.contains(dateString){
            return [#colorLiteral(red: 0.9411764706, green: 0.3725490196, blue: 0.231372549, alpha: 1)]
        }else if completedDates.contains(dateString){
            return [#colorLiteral(red: 0.5411764706, green: 0.5411764706, blue: 0.5411764706, alpha: 1)]
        }else if pendingDates.contains(dateString){
            return [#colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.431372549, alpha: 1)]
        }
        return nil
    }

}

class RoundLabel:UILabel{
    @IBInspectable var cornerRadius: CGFloat = 8.0 {
        didSet {
            self.updateProperties()
        }
    }
    func updateProperties(){
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = true
    }
}
/* *
 func leftArrow(_ sender:UIButton){
 let minDateString = self.formatter.string(from: self.calenderViewInView.minimumDate).components(separatedBy: "/")
 let minYear = minDateString[0].toInt
 var dateString = self.formatter.string(from: self.calenderViewInView.currentPage).components(separatedBy: "/")
 let year = dateString[0].toInt - 1
 dateString.remove(at: 0)
 dateString.insert("\(year)", at: 0)
 let finalDate = dateString.joined(separator: "/")
 let cal = NSCalendar.init(identifier: .gregorian)?.date(byAdding: NSCalendar.Unit.year, value: -1, to: self.calenderViewInView.currentPage, options: NSCalendar.Options.matchFirst)
 if minYear <= year{
 self.calenderViewInView.setCurrentPage(self.formatter.date(from: finalDate)!, animated: true)
 }
 }
 
 func rightArrow(_ sender:UIButton){
 let maxDateString = self.formatter.string(from: self.calenderViewInView.maximumDate).components(separatedBy: "/")
 let maxYear = maxDateString[0].toInt
 var dateString = self.formatter.string(from: self.calenderViewInView.currentPage).components(separatedBy: "/")
 let year = dateString[0].toInt + 1
 dateString.remove(at: 0)
 dateString.insert("\(year)", at: 0)
 let finalDate = dateString.joined(separator: "/")
 if maxYear >= year{
 self.calenderViewInView.setCurrentPage(self.formatter.date(from: finalDate)!, animated: true)
 }
 }
 */
