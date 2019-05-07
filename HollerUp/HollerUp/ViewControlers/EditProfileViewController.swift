//
//  EditProfileViewController.swift
//  HollerUp
//
//  Created by Vamsi on 17/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class EditProfileViewController: UIViewController {

    @IBOutlet var viewsInView: [UIView]!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
    var selectedImage :UIImage!
    var selectedImageBase64String : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        TheGlobalPoolManager.cornerAndBorder(self.profilePic, cornerRadius: self.profilePic.h / 2, borderWidth: 0, borderColor: .clear)
        self.uploadBtn.setImage(#imageLiteral(resourceName: "Camera").withColor(.whiteColor), for: .normal)
        for view in viewsInView{
            view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
        }
        self.saveBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 10)
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
    @IBAction func saveBtn(_ sender: UIButton) {
    }
    @IBAction func uploadBtn(_ sender: UIButton) {
        self.imagePicking("Upload Profile Pic")
    }
}
extension EditProfileViewController  : UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverPresentationControllerDelegate{
    //MARK: - Image Picking
    func imagePicking(_ title:String){
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
        if UIDevice.current.userInterfaceIdiom == .pad {
            print("IPAD")
            actionSheetController.modalPresentationStyle = .popover
            let popover = actionSheetController.popoverPresentationController!
            popover.delegate = self
            popover.sourceView = self.view
            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popover.permittedArrowDirections = []
            self.present(actionSheetController, animated: true, completion: nil )
        }
        else if UIDevice.current.userInterfaceIdiom == .phone{
            print("IPHONE")
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
                print("Camera not available....")
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
        }else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage = image
        }else{
            print("Something went wrong")
        }
        convertImage(image: selectedImage)
        print(selectedImage)
        self.profilePic.image = selectedImage
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func convertImage(image: UIImage) {
        let imageData = UIImageJPEGRepresentation(image, 0.1)! as NSData
        let dataString = imageData.base64EncodedString()
        selectedImageBase64String = dataString
        print("*************** Base 64 String =========\(selectedImageBase64String)")
    }
}
