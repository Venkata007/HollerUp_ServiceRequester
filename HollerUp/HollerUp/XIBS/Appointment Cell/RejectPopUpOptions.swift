//
//  RejectPopUpOptions.swift
//  HollerUp
//
//  Created by Vamsi on 25/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class RejectPopUpOptions: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var slotLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: TableViewCellIdentifiers.RejectOptionsCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.RejectOptionsCell)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        ez.runThisInMainThread {
            TheGlobalPoolManager.cornerAndBorder(self.view, cornerRadius: 15, borderWidth: 0, borderColor: .clear)
        }
        self.imgView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 5)
    }
    //MARK:- IB Action Outlets
    @IBAction func cancelBtn(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("Reject_CancelButton"), object: nil)
    }
    @IBAction func confirmBtn(_ sender: UIButton) {
    }
}
extension RejectPopUpOptions: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.RejectOptionsCell) as! RejectOptionsCell
        cell.selectionStyle = .default
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RejectOptionsCell
        cell.cellSelected(true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  30
    }
}

