//
//  SynchCalendarVC.swift
//  HollerUp
//
//  Created by Vamsi on 27/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class SynchCalendarVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
    var menuItems = ["Gmail","Outlook","Phone Calendar"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        self.tableView.separatorInset = .zero
        self.tableView.layoutMargins = .zero
        self.tableView.tableFooterView = UIView()
        self.doneBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.dismissVC(completion: nil)
    }
    @IBAction func doneBtn(_ sender: UIButton) {
    }
}
class SynchOptionsCell : UITableViewCell{
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.switch.tintColor = .clear
        self.switch.thumbTintColor = .whiteColor
        self.switch.backgroundColor = .secondaryColor1
        self.switch.layer.cornerRadius = self.switch.bounds.height / 2
        self.switch.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius :  self.switch.bounds.height / 2)
    }
}
extension SynchCalendarVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.SynchOptionsCell) as! SynchOptionsCell
        cell.textLbl.text = menuItems[indexPath.row]
        cell.switch.tag = indexPath.row
        cell.switch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        cell.selectionStyle = .none
        tableView.rowHeight = UIDevice.isPhone() ? 50 : 60
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    @objc func switchChanged(_ sender : UISwitch!){
        switch sender.tag {
        case 0:
            if sender.isOn{
                print("Gmail ON")
            }else{
                print("Gmail OFF")
            }
        case 1:
            if sender.isOn{
                print("Outlook ON")
            }else{
                print("Outlook OFF")
            }
        case 2:
            if sender.isOn{
                print("Phone ON")
            }else{
                print("Phone OFF")
            }
        default:
            break
        }
    }
}
