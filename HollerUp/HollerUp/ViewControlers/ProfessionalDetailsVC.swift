//
//  ProfessionalDetailsVC.swift
//  HollerUp
//
//  Created by Vamsi on 28/03/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit

class ProfessionalDetailsVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var professionTF: UITextField!
    @IBOutlet weak var departmentTF: UITextField!
    @IBOutlet weak var experienceTF: UITextField!
    @IBOutlet weak var certificationTF: UITextField!
    
    var selectedImage :UIImage!
    var selectedImageBase64String : String = ""
    
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
        professionTF.setBottomBorder()
        departmentTF.setBottomBorder()
        experienceTF.setBottomBorder()
        certificationTF.setBottomBorder()
    }
    //MARK:- IB Action Outlets
}
class DocumentsCell : UITableViewCell{
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
}
class AddNewCell : UITableViewCell{
    @IBOutlet weak var addNewBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        TheGlobalPoolManager.cornerAndBorder(addNewBtn, cornerRadius: 0, borderWidth: 1, borderColor: .themeColor)
        self.addNewBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
    }
}
class SaveButtonCell : UITableViewCell{
    @IBOutlet weak var saveBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.saveBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
    }
}
extension ProfessionalDetailsVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.AddNewCell) as! AddNewCell
            cell.addNewBtn.addTarget(self, action: #selector(addNewDocumentMethod(_:)), for: .touchUpInside)
            return cell
        }else if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.SaveButtonCell) as! SaveButtonCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.DocumentsCell) as! DocumentsCell
            cell.titleLbl.text = "Document 0\(indexPath.row + 1)"
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4{
            return 70
        }else if indexPath.row == 5{
            return 100
        }else{
           return 40
        }
    }
}
extension ProfessionalDetailsVC{
    @objc func addNewDocumentMethod(_ btn : UIButton){
        self.imagePicking("Upload Document")
    }
    //MARK: - Image Picking
    func imagePicking(_ title:String){
        if UIDevice.current.userInterfaceIdiom == .pad {
            print("IPAD")
        }
        else if UIDevice.current.userInterfaceIdiom == .phone{
            let actionSheetController = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
            
            let cameraActionButton = UIAlertAction(title: "Take a picture", style: .default) { action -> Void in
                self.imagePicker(clickedButtonat: 0)
            }
            let photoAlbumActionButton = UIAlertAction(title: "Camera roll", style: .default) { action -> Void in
                self.imagePicker(clickedButtonat: 1)
            }
            let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            }
            actionSheetController.addAction(cameraActionButton)
            actionSheetController.addAction(photoAlbumActionButton)
            actionSheetController.addAction(cancelActionButton)
            self.present(actionSheetController, animated: true, completion: nil)
        }
    }
    // MARK: - Image picker from gallery and camera
    private func imagePicker(clickedButtonat buttonIndex: Int) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        switch buttonIndex {
        case 0:
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                picker.sourceType = .camera
                present(picker, animated: true, completion: nil)
            }
            else{
                TheGlobalPoolManager.showToastView("Camera Is not Available")
            }
        case 1:
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion:nil)
        default:
            break
        }
    }
    // MARK: - UIImagePickerController delegate methods
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImage = image
        }
        else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage = image
        } else{
            print("Something went wrong")
        }
        convertImage(image: selectedImage)
        print(selectedImage)
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func convertImage(image: UIImage) {
        let imageData = UIImageJPEGRepresentation(image, 0.1)! as NSData
        let dataString = imageData.base64EncodedString()
        selectedImageBase64String = dataString
        print(" *************** Base 64 String =========\(selectedImageBase64String)")
    }
}

