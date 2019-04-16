//
//  ProfileViewController.swift
//  HollerUp
//
//  Created by Vamsi on 08/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var titleArray = ["Mobile","Email ID","Payment Details","Settings","Refer & Earn"]
    var detailsArray = ["+91 9533565007","vamsi@gmail.com","ICICI Bank","",""]
    var imagesArray = [#imageLiteral(resourceName: "Mobile"),#imageLiteral(resourceName: "Mail_id"),#imageLiteral(resourceName: "Payments"),#imageLiteral(resourceName: "Settings"),#imageLiteral(resourceName: "Refer")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: TableViewCellIdentifiers.NameCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.NameCell)
        self.tableView.register(UINib(nibName: TableViewCellIdentifiers.ProfileDetailsCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.ProfileDetailsCell)
        self.tableView.register(UINib(nibName: TableViewCellIdentifiers.LogoutCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.LogoutCell)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        self.tableView.tableFooterView = UIView()
    }
    //MARK:- IB Action Outlets
}
extension ProfileViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.NameCell) as! NameCell
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.LogoutCell) as! LogoutCell
            cell.switch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.ProfileDetailsCell) as! ProfileDetailsCell
            cell.selectionStyle = .none
            cell.titleLbl.text = titleArray[indexPath.section - 1]
            cell.contentLbl.text = detailsArray[indexPath.section - 1]
            cell.imgView.image = imagesArray[indexPath.section - 1]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return UIDevice.isPhone() ? 180 : 180
        }
        return  UIDevice.isPhone() ? 50 : 80
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 10
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        TheGlobalPoolManager.cornerAndBorder(headerView, cornerRadius: 0, borderWidth: 0.5, borderColor: .lightGray)
        return headerView
    }
    //Logout Switch Method
    @objc func switchChanged(_ sender : UISwitch!){
        if sender.isOn{
            print("ONNNnnnnnnnn")
        }else{
            TheGlobalPoolManager.showAlertWith(title: "Are you sure", message: "Do you want to Logout?", singleAction: false, okTitle:"Confirm") { (sucess) in
                if sucess!{
                    if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIDs.LoginViewController) as? LoginViewController{
                        self.navigationController?.pushViewController(viewCon, animated: true)
                    }
                }
            }
        }
    }
}
