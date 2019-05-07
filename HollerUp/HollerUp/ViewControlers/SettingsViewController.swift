
//
//  SettingsViewController.swift
//  HollerUp
//
//  Created by Vamsi on 07/05/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class SettingsViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var settings = ["Change Password","Help & Support","Give us feedback","Contact US"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
}
class SettingsCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
}
extension SettingsViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.SettingsCell) as! SettingsCell
        cell.titleLbl.text = self.settings[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIDs.ResetPasswordVC) as? ResetPasswordVC{
                viewCon.hidesBottomBarWhenPushed = true
                viewCon.isComingFromSettings = true
                self.navigationController?.pushViewController(viewCon, animated: true)
            }
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
