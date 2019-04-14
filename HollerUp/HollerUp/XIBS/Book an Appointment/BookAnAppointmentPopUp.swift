//
//  BookAnAppointmentPopUp.swift
//  HollerUp
//
//  Created by Vamsi on 09/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class BookAnAppointmentPopUp: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var qualificationLbl: UILabel!
    @IBOutlet weak var expLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var slotLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        ez.runThisInMainThread {
            TheGlobalPoolManager.cornerAndBorder(self.view, cornerRadius: 15, borderWidth: 0, borderColor: .clear)
        }
        self.imgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
    }
    //MARK:- IB Action Outlets
    @IBAction func cancelBtn(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("BookAppointment_CancelButton"), object: nil)
    }
    @IBAction func confirmBtn(_ sender: UIButton) {
    }
}
