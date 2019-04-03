//
//  PickerView.swift
//  HollerUp
//
//  Created by Hexadots on 27/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

protocol PickerViewDelegate: NSObjectProtocol {
    func pickerViewDidSelectDate(_ date: Date)
}

class PickerView: UIView, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var selectedBtn: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pickerSuperView: UIView!
    @IBOutlet weak var headerdateLbl: UILabel!
    
    //Delegate
    var delegate: PickerViewDelegate?
    
    //Custom Properties
    open var showBlur = true //Default Yes
    open var tapToDismiss = true //Default Yes
    open var showShadow = true //Optional
    open var showCornerRadius = true // Optional
    
    @IBInspectable var btnFontColour: UIColor = .whiteColor {
        didSet {
            self.updateProperties()
        }
    }
    
    @IBInspectable var btnTitle: String = "Select" {
        didSet {
            self.updateProperties()
        }
    }
    
    @IBInspectable var btnFont: UIFont = UIFont.appFont(.Medium) {
        didSet {
            self.updateProperties()
        }
    }
    
    @IBInspectable var btnColour: UIColor = .themeColor {
        didSet {
            self.updateProperties()
        }
    }
    
    @IBInspectable var datePickerStartDate: Date = Date() {
        didSet {
            self.updateProperties()
        }
    }
    
    @IBInspectable var datePickerMode: UIDatePickerMode = UIDatePickerMode.date {
        didSet {
            self.updateProperties()
        }
    }
    
    @IBInspectable var datePickerTimeInterval: Int = 1 {
        didSet {
            self.updateProperties()
        }
    }
    
    @IBInspectable var nameLbl: String = "From" {
        didSet {
            self.updateProperties()
        }
    }
    
    func updateProperties(){
        self.selectedBtn.setTitle(btnTitle, for: .normal)
        self.selectedBtn.titleLabel?.font = btnFont
        self.selectedBtn.tintColor = self.btnFontColour
        self.selectedBtn.backgroundColor = self.btnColour
        self.datePickerView.date = self.datePickerStartDate
        self.datePickerView.datePickerMode = self.datePickerMode
        self.datePickerView.minuteInterval = self.datePickerTimeInterval
        ez.runThisInMainThread {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE dd'th' MMMM,  hh:mm a"
            let selectedDate: String = dateFormatter.string(from: Date())
            self.headerdateLbl.attributedText = TheGlobalPoolManager.attributedTextWithTwoDifferentTextsWithFont(self.nameLbl + "\n", attr2Text: selectedDate, attr1Color: .whiteColor, attr2Color: .whiteColor, attr1Font: UIDevice.isPhone() ? 16 : 18, attr2Font: UIDevice.isPhone() ? 14 : 16, attr1FontName: AppFonts.Medium, attr2FontName: AppFonts.Regular)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("PickerView", owner: self, options: nil)
        self.contentView.w = ez.screenWidth
        self.contentView.h = ez.topMostVC?.view.bounds.height ?? 0
        self.addSubview(self.contentView)
    }

    @IBAction func selectDateBtn(_ sender: UIButton) {
        if delegate != nil {
            self.delegate?.pickerViewDidSelectDate(self.datePickerView.date)
            self.dismiss()
        }
    }
    
    open func show(attachToView view: UIView) {
        self.show(self, inView: view)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: self.pickerSuperView){
            return false
        }
        return true
    }
    
    fileprivate func show(_ contentView: UIView, inView: UIView) {
        
        self.frame = inView.frame
        self.containerView.backgroundColor = UIColor.clear
        self.containerView.alpha = 0
        
        inView.addSubview(self)
        self.containerView.frame.origin.y = inView.bounds.height
        //Show UI Views
        UIView.animate(withDuration: 0.15, animations: {
            self.containerView.alpha = 1
        }, completion: { (success:Bool) in
            UIView.animate(withDuration: 0.30, delay: 0, options: .transitionCrossDissolve, animations: {
                //self.backgroundView.frame.origin.y = self.containerView.bounds.height / 2 - 125
                self.containerView.frame.origin.y = 0
            }, completion: { (success:Bool) in
            })
        })
        if tapToDismiss {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismiss(_:)))
            tap.delegate = self
            self.containerView.addGestureRecognizer(tap)
        }
        self.layoutSubviews()
    }
    //Handle Tap Dismiss
    @objc func dismiss(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.15, animations: {
            self.pickerSuperView.frame.origin.y += self.containerView.bounds.maxY
        }, completion: { (success:Bool) in
            UIView.animate(withDuration: 0.05, delay: 0, options: .transitionCrossDissolve, animations: {
                self.containerView.alpha = 0
            }, completion: { (success:Bool) in
                self.containerView.removeGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(self.dismiss(_:))))
                self.containerView.removeFromSuperview()
                self.removeFromSuperview()
            })
        })
    }
}
extension PickerView{
    func datePickerValueChanged(_ sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd'th' MMMM,  hh:mm a"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        print("Selected value \(selectedDate)")
        ez.runThisInMainThread {
            self.headerdateLbl.attributedText = TheGlobalPoolManager.attributedTextWithTwoDifferentTextsWithFont(self.nameLbl + "\n", attr2Text: selectedDate, attr1Color: .whiteColor, attr2Color: .whiteColor, attr1Font: UIDevice.isPhone() ? 16 : 18, attr2Font: UIDevice.isPhone() ? 14 : 16, attr1FontName: AppFonts.Medium, attr2FontName: AppFonts.Regular)
        }
    }
}
