//
//  PaymentsDetailsVC.swift
//  HollerUp
//
//  Created by Vamsi on 29/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit

class PaymentsDetailsVC: UIViewController {

    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var bankAccountNoTF: UITextField!
    @IBOutlet weak var bankNameTF: UITextField!
    @IBOutlet var typeOfAccountsBtns: [UIButton]!
    @IBOutlet var paymentFreqBtns: [UIButton]!
    @IBOutlet weak var saveBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        mobileNumberTF.setBottomBorder()
        bankAccountNoTF.setBottomBorder()
        bankNameTF.setBottomBorder()
        for btn in paymentFreqBtns{
            if btn.tag == 0{
                self .paymentFreqBtns(btn)
            }
        }
        for btn in typeOfAccountsBtns{
            if btn.tag == 0{
                self .typeOfAccountBtns(btn)
            }
        }
         self.saveBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
    }
    //MARK:- IB Action Outlets
    @IBAction func typeOfAccountBtns(_ sender: UIButton) {
        for button in typeOfAccountsBtns {
            if button == sender {
                button.isSelected = true
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                if button.tag == 0{
                    button.setImage(#imageLiteral(resourceName: "Radio_On"), for: .normal)
                }
                else  if button.tag == 1{
                    button.setImage(#imageLiteral(resourceName: "Radio_On"), for: .normal)
                }
            }
            else{
                button.isSelected = false
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setImage(#imageLiteral(resourceName: "Radio_Off"), for: .normal)
            }
        }
    }
    @IBAction func paymentFreqBtns(_ sender: UIButton) {
        for button in paymentFreqBtns {
            if button == sender {
                button.isSelected = true
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                if button.tag == 0{
                    button.setImage(#imageLiteral(resourceName: "Radio_On"), for: .normal)
                }
                else  if button.tag == 1{
                    button.setImage(#imageLiteral(resourceName: "Radio_On"), for: .normal)
                }
            }
            else{
                button.isSelected = false
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setImage(#imageLiteral(resourceName: "Radio_Off"), for: .normal)
            }
        }
    }
    @IBAction func saveBtn(_ sender: Any) {
    }
}
