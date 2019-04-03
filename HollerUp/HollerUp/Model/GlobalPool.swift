


//
//  GlobalPool.swift
//  DoorVideoCall
//
//  Created by Harshal Choksi on 4/11/17.
//  Copyright © 2017 Twilio, Inc. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import MMMaterialDesignSpinner


let TheGlobalPoolManager = GlobalPool.sharedInstance

class GlobalPool: NSObject {
    typealias AlertCallback = (Bool?) -> ()
    static let sharedInstance = GlobalPool()
    var appName:String = "HollerUp"
    var defaults = UserDefaults.standard
    var deviceToken : String = "DEVICE_TOKEN"
    let device_id = UIDevice.current.identifierForVendor!.uuidString
    var spinnerView:MMMaterialDesignSpinner=MMMaterialDesignSpinner()
    let dispatch = Dispatcher()
    var view:UIView{return (ez.topMostVC?.view)!}
    var vc:UIViewController{return ez.topMostVC!}
    var isAlertDisplaying = false
    override init() {
        super.init()
    }
    func showToastView(_ title: String) {
        Toast.init(text: title, duration: 2.0).show()
    }
    func showProgress(view:UIView){
        ez.runThisInMainThread {
            view.isUserInteractionEnabled = false
            self.spinnerView.frame=CGRect(x: view.center.x-25, y: view.center.y, width: 35, height: 35)
            self.spinnerView.lineWidth = 3.0;
            self.spinnerView.tintColor = .themeColor
            TheGlobalPoolManager.cornerAndBorder(self.spinnerView, cornerRadius: self.spinnerView.w / 2, borderWidth: 1, borderColor: .lightGray)
            view.addSubview(self.spinnerView)
            self.spinnerView.startAnimating()
        }
    }
    func hideProgess(view:UIView){
        view.isUserInteractionEnabled = true
        spinnerView.stopAnimating()
        spinnerView.removeFromSuperview()
    }
    //MARK: - UIButton Border and Corner radius
    func buttonMethod(button:UIButton)  {
        button.layer.borderColor = UIColor.blackColor.cgColor
        button.layer.borderWidth=2.0
        button.layer.cornerRadius=10
    }
    //MARK: - Internet Reachability
    func internetAvailability() -> Bool{
        let reachability = Reachability.forInternetConnection()
        reachability?.startNotifier()
        let status = reachability?.currentReachabilityStatus()
        if(status == NotReachable){
            return false
        }
        else if (status == ReachableViaWiFi){
            //WiFi
            reachability?.stopNotifier()
            return true
        }
        else if (status == ReachableViaWWAN){
            //3G
            reachability?.stopNotifier()
            return true
        }
        return false
    }
    // MARK: - Internet Connection
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
    }
    // MARK: - Converting Total Seconds to hh:mm:ss
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    // MARK: - Counting Age
    func ageCount(_ birthYear: String) -> String {
        let components: DateComponents? = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        let age = Int((components?.year)!) - (birthYear as NSString).integerValue
        return "\(age - 1)"
    }
    //MARK: - Removing Special Characters from string
    func removeSpecialCharactersInArray(_ stringToRemove:String) -> String{
        let string = stringToRemove
        let removeChars = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890,.:!_\'")
        let charArray = string.components(separatedBy:removeChars.inverted) as NSArray
        let removedString = charArray.componentsJoined(by: "")
        return removedString
    }
    // MARK: - De-coding to Base 64 String UIImage
    func decodeBase64(toImage strEncodeData: String) -> UIImage {
        let data = Data(base64Encoded: strEncodeData, options: .ignoreUnknownCharacters)
        return UIImage(data: data!)!
    }
    // MARK: - Change CentiMeters To Feet And Inches
    func changeCentiMetersToFeetAndInches(_ centimeter:Float) -> String{
        let INCH_IN_CM: Float = 2.54
        let numInches = Int(roundf(centimeter / INCH_IN_CM))
        let feet: Int = numInches / 12
        let inches: Int = numInches % 12
        return "\(feet)'\(inches)\""
    }
    // MARK: - Draw Dotted Line
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: AnyObject, color:CGColor = UIColor.lightGray.cgColor, lineWidth: CGFloat = 1) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineDashPattern = [8, 5] // 8 is the length of dash, 5 is length of the gap.
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }

    //MARK:- UIButton Border and Corner radius
    func cornerAndBorder(_ object:AnyObject, cornerRadius : CGFloat , borderWidth : CGFloat, borderColor:UIColor)  {
        object.layer.borderColor = borderColor.cgColor
        object.layer.borderWidth = borderWidth
        object.layer.cornerRadius = cornerRadius
        object.layer.masksToBounds = true
    }
    //MARK:- corner Radius For Header
    func cornerRadiusForParticularCornerr(_ object:AnyObject,  corners:UIRectCorner,  size:CGSize){
        let path = UIBezierPath(roundedRect:object.bounds,
                                byRoundingCorners:corners,
                                cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        object.layer.mask = maskLayer
    }
    func getTodayString() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: date)
        return date24
    }
    //MARK: - Email Validation
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    //MARK: - UIButton Border and Corner radius
    func viewFrameMethod(view:UIView)  {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.themeColor.cgColor
        view.layer.cornerRadius=27
        view.layer.masksToBounds = true
    }
    //MARK: - Text Field Frame and Corner radius
    func textFieldFrame(_ tf: UITextField, placeHolder placeStr: String) {
        tf.layer.cornerRadius = 5
        tf.layer.borderWidth = 0
        let color = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
        tf.attributedPlaceholder = NSAttributedString(string: placeStr, attributes: [NSAttributedStringKey.foregroundColor: color])
        tf.layer.masksToBounds = true
    }
    //MARK: - Label Frame and Corner radius
    func labelFrame(_ label: UILabel) {
        label.layer.cornerRadius = 25
        label.layer.masksToBounds = true
    }
    //MARK: - Printing JSON Object.
    func jsonToString(json: AnyObject){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "")
        } catch let myJSONError {
            print("Error jsonToString",myJSONError)
        }
    }
    //MARK: - Logout Method
    func logout(){
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
            UIApplication.shared.unregisterForRemoteNotifications()
        }
    }
    //MARK: - Get Top Most VC
    func getTopMostVC() ->UIViewController?{
        let appdel = UIApplication.shared.delegate as! AppDelegate
        var top = appdel.window?.rootViewController!
        while ((top?.presentedViewController) != nil) {
            top = top?.presentedViewController!
            return top
        }
        if top?.presentedViewController == nil{
            return appdel.window?.rootViewController
        }
        return nil
    }
    //MARK:- Added Top Shadow
    func addTopShadow(_ view : UIView) {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 4)
        let backgroundView = UIView(frame: frame)
        view.addSubview(backgroundView)
        //A linear Gradient Consists of two colours: top colour and bottom colour
        let topColor = UIColor.lightGray
        let bottomColor = UIColor.clear
        //Add the top and bottom colours to an array and setup the location of those two.
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [CGFloat] = [0.0, 1.0]
        //Create a Gradient CA layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = frame
        gradientLayer.opacity = 0.2
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        backgroundView.layer.zPosition = 100
    }
    //MARK:- NS Attributed Text With Color and Font
    func attributedTextWithTwoDifferentTextsWithFont(_ attr1Text : String , attr2Text : String , attr1Color : UIColor , attr2Color : UIColor , attr1Font : Int , attr2Font : Int , attr1FontName : AppFonts , attr2FontName : AppFonts) -> NSAttributedString{
        let attrs1 = [NSAttributedStringKey.font : UIFont.init(name: attr1FontName.fonts, size: CGFloat(attr1Font))!, NSAttributedStringKey.foregroundColor : attr1Color] as [NSAttributedStringKey : Any]
        let attrs2 = [NSAttributedStringKey.font : UIFont.init(name: attr2FontName.fonts, size: CGFloat(attr2Font))!, NSAttributedStringKey.foregroundColor : attr2Color] as [NSAttributedStringKey : Any]
        let attributedString1 = NSMutableAttributedString(string:attr1Text, attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:attr2Text, attributes:attrs2)
        attributedString1.append(attributedString2)
        return attributedString1
    }
    //MARK:- UIAlertController
    func showAlertWith(title:String = "", message:String, singleAction:Bool,  okTitle:String = "Ok", cancelTitle:String = "Cancel", callback:@escaping AlertCallback) {
        self.isAlertDisplaying = true
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: okTitle, style: .default) { action -> Void in
            self.isAlertDisplaying = false
            callback(true)
        }
        if !singleAction{
            let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .default) { action -> Void in
                //Just dismiss the action sheet
                self.isAlertDisplaying = false
                callback(false)
            }
            alertController.addAction(cancelAction)
        }
        alertController.addAction(okAction)
        ez.runThisInMainThread {
            self.vc.presentVC(alertController)
        }
    }
}
class UILabelPadded: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}

class UITextFieldPadded: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 25)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
class Dispatcher{
    enum DispatchLevel{
        case Main, UserInteractive, UserInitiated, Utility, Background
        var dispatchQueue: DispatchQueue {
            switch self {
            case .Main:             return DispatchQueue.main
            case .UserInteractive:  return DispatchQueue.global(qos: .userInteractive)
            case .UserInitiated:    return DispatchQueue.global(qos: .userInitiated)
            case .Utility:          return DispatchQueue.global(qos: .utility)
            case .Background:       return DispatchQueue.global(qos: .background)
            }
        }
    }
    func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .Main, closure: @escaping () -> Void)
    {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            closure()
        }
    }
}
//MARK:- UI Button
class ButtonWithShadow: UIButton {
    override func draw(_ rect: CGRect) {
        updateLayerProperties()
    }
    func updateLayerProperties() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 2.0
        self.layer.shadowRadius = 3.0
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
    }
}
//MARK:- UI Button Icon Right
class ButtonIconRight: UIButton {
    override func imageRect(forContentRect contentRect:CGRect) -> CGRect {
        var imageFrame = super.imageRect(forContentRect: contentRect)
        imageFrame.origin.x = super.titleRect(forContentRect: contentRect).maxX - imageFrame.width
        return imageFrame
    }
    override func titleRect(forContentRect contentRect:CGRect) -> CGRect {
        var titleFrame = super.titleRect(forContentRect: contentRect)
        if (self.currentImage != nil) {
            titleFrame.origin.x  = super.imageRect(forContentRect: contentRect).minX
        }
        return titleFrame
    }
}
