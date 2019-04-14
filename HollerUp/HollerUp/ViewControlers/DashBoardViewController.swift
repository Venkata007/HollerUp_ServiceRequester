//
//  DashBoardViewController.swift
//  HollerUp
//
//  Created by Vamsi on 08/04/19.
//  Copyright © 2019 iOSDevelopers. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class DashBoardViewController: UIViewController,PickerViewDelegate{

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var viewInView: UIView!
    @IBOutlet weak var subViewInView: UIView!
    @IBOutlet var subViews: [UIView]!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var availabilityTF: UITextField!
    @IBOutlet weak var searchForServiceTF: UITextField!
    @IBOutlet var servicesBtns: [UIButton]!
    
    var locationManager: CLLocationManager?
    var myLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var lat: Float = 0.0
    var long: Float = 0.0
    var selectedLocation : String!
    var selectedLatitude : Double!
    var selectedLongitude : Double!
    
    var datePicker:PickerView!
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        self.searchForServiceTF.delegate = self
        self.locationTF.delegate = self
        self.availabilityTF.delegate = self
        
        self.headerView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 0)
       self.subViewInView.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
        ez.runThisInMainThread {
            TheGlobalPoolManager.cornerAndBorder(self.viewInView, cornerRadius: self.viewInView.w / 2, borderWidth: 0, borderColor: .clear)
        }
        for view in subViews{
            view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
        }
        self.searchBtn.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 3.0, opacity: 0.35 ,cornerRadius : 8)
        
        placesClient = GMSPlacesClient.shared()
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    print("Place name \(place.name!)")
                    print("Place address \(place.formattedAddress!)")
                    print("Place Latitude \(place.coordinate.latitude)")
                    print("Place Longitude \(place.coordinate.longitude)")
                    self.lat = Float(place.coordinate.latitude)
                    self.long = Float(place.coordinate.longitude)
                }
            }
        })
    }
    //MARK:- IB Action Outlets
    @IBAction func searchBtn(_ sender: UIButton) {
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIDs.SearchViewController) as? SearchViewController{
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    @IBAction func servicesBtns(_ sender: UIButton) {
    }
}
extension DashBoardViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case searchForServiceTF:
            searchForServiceTF.resignFirstResponder()
            print(":::::::::::::::::::::::::::::::::::    Search For Service    :::::::::::::::::::::::::::::::::::::")
            return false
        case locationTF:
            locationTF.resignFirstResponder()
            print(":::::::::::::::::::::::::::::::::::    Location    :::::::::::::::::::::::::::::::::::::")
            self.view.endEditing(true)
            locationManager = CLLocationManager()
            locationManager?.requestAlwaysAuthorization()
            locationManager?.startUpdatingLocation()
            myLocation = locationManager?.location
            let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(lat), CLLocationDegrees(long))
            let northEast: CLLocationCoordinate2D = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
            let southWest: CLLocationCoordinate2D = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
            let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
            let config = GMSPlacePickerConfig(viewport: viewport)
            let placePicker = GMSPlacePickerViewController(config: config)
            placePicker.delegate = self
            present(placePicker, animated: true, completion: nil)
            return false
        case availabilityTF:
            availabilityTF.resignFirstResponder()
            print(":::::::::::::::::::::::::::::::::::    Availability    :::::::::::::::::::::::::::::::::::::")
            self.datePickerView("Availability")
            return false
        default:
            break
        }
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
extension DashBoardViewController : CLLocationManagerDelegate,UISearchBarDelegate,GMSPlacePickerViewControllerDelegate{
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        print("Place name \(place.name!)")
        print("Place address \(place.formattedAddress!)")
        print("Place Latitude \(place.coordinate.latitude)")
        print("Place Longitude \(place.coordinate.longitude)")
        self.locationTF.text = place.formattedAddress!
        selectedLocation = place.formattedAddress?.replacingOccurrences(of: ",", with: "\n")
        selectedLatitude = (place.coordinate.latitude)
        selectedLongitude = place.coordinate.longitude
        locationManager?.stopUpdatingLocation()
        viewController.dismiss(animated: true, completion: nil)
    }
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        print("No place selected")
    }
}
extension DashBoardViewController {
    func datePickerView( _ btnName : String){
        self.datePicker = nil
        self.datePicker = PickerView(frame: self.view.frame)
        self.datePicker.tapToDismiss = true
        self.datePicker.datePickerMode = .dateAndTime
        self.datePicker.showBlur = true
        self.datePicker.datePickerStartDate = self.date
        self.datePicker.btnFontColour = UIColor.white
        self.datePicker.btnColour = .themeColor
        self.datePicker.showCornerRadius = false
        self.datePicker.delegate = self
        self.datePicker.nameLbl = btnName
        self.datePicker.show(attachToView: self.view)
    }
    //MARK : - Gertting Age  based on DOB
    func pickerViewDidSelectDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY HH:mm"
        dateFormatter.timeZone = NSTimeZone.local
        let strDate = dateFormatter.string(from: (date))
        print(strDate)
        self.availabilityTF.text = strDate
    }
}
