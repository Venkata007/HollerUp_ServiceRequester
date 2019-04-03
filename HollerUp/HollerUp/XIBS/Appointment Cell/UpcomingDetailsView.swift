//
//  UpcomingDetailsView.swift
//  HollerUp
//
//  Created by Vamsi on 25/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class UpcomingDetailsView: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var slotTimeLbl: UILabel!
    @IBOutlet weak var acceptedTimeLbl: UILabel!
    @IBOutlet weak var regardingLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        ez.runThisInMainThread {
            self.view.frame.size.height = self.regardingLbl.frame.size.height + 160
            TheGlobalPoolManager.cornerAndBorder(self.view, cornerRadius: 15, borderWidth: 0, borderColor: .clear)
        }
         self.imgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 5)
    }
}
