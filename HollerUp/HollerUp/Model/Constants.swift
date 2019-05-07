//
//  Constants.swift
//  QHost
//
//  Created by Admin on 29/06/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import UIKit
let SERVER_IP       = "http://13.233.109.143:1234"
let LOCAL_IP        = "http://192.168.100.88:1234"
let SERVER_URL1 = "\(SERVER_IP)/api/v1"
let SERVER_URL2 = "\(SERVER_IP)/"
public struct Constants {
    static let AppName                                   = "HollerUp"
    static let TERMS_AND_SERVICES_URL = ""
    static let StoryBoardName                      = "Main"
}
//MARK : - ViewController IDs
public  struct ViewControllerIDs {
    static let TabBarController                            = "TabBarController"
    static let LoginViewController                      = "LoginViewController"
    static let ForgotPasswordVC                         = "ForgotPasswordVC"
    static let ResetPasswordVC                           = "ResetPasswordVC"
    static let ChangePasswordVC                      = "ChangePasswordVC"
    static let SignUpViewController                  = "SignUpViewController"
    static let SignUpView1                                  = "SignUpView1"
    static let SignUpVie2                                     = "SignUpView2"
    static let DashBoardViewController           = "DashBoardViewController"
    static let ProfileViewController                    = "ProfileViewController"
    static let BookingsViewController              = "BookingsViewController"
    static let SearchViewController                   = "SearchViewController"
    static let ServiceProviderDetailVC              = "ServiceProviderDetailVC"
    static let PaymentViewController                = "PaymentViewController"
    static let EditProfileViewController             = "EditProfileViewController"
    static let SettingsViewController                 = "SettingsViewController"
}
//MARK:- TableViewCellIdentifiers
public struct TableViewCellIdentifiers{
    static let NameCell                                              = "NameCell"
    static let ProfileDetailsCell                                 = "ProfileDetailsCell"
    static let LogoutCell                                            =  "LogoutCell"
    static let CurrentBookingCell                            = "CurrentBookingCell"
    static let BookingsHistoryCell                           = "BookingsHistoryCell"
    static let ServiceProviderCell                            = "ServiceProviderCell"
    static let SettingsCell                                          = "SettingsCell"
}
//MARK:- XIB Names
public struct CollectionViewCellIdentifiers{
    static let UpcomingCallsCell                             =  "UpcomingCallsCell"
    static let NextAvailabilityCell                            = "NextAvailabilityCell"
}
//MARK : - Device INFO
public struct DeviceInfo {
    static let DefaultDeviceToken = "2222222"
    static let DeviceType                = "IOS"
    static let Device                         = "MOBILE"
}
//MARK : - All Apis
public struct ApiURls{
    static let add_current_address                          = "\(SERVER_URL1)/address/add/customer/current"
}
// MARK : - Toast Messages
public struct ToastMessages {
    static let  Unable_To_Sign_UP          = "Unable to register now, Please try again...😞"
    static let Check_Internet_Connection   = "Please check internet connection"
    static let Some_thing_went_wrong       = "Something went wrong...🙃, Please try again."
    static let Invalid_Credentials         = "Invalid credentials...🤔"
    static let Success                     = "Success...😀"
    static let Email_Address_Is_Not_Valid  = "Email address is not valid"
    static let Invalid_Email               = "Invalid Email Address"
    static let Invalid_FirstName           = "Invalid FirstName"
    static let Invalid_LastName           = "Invalid LastName"
    static let Invalid_Number              = "Invalid Mobile Number"
    static let Invalid_Password            = "Password must contains min 6 character"
    static let Invalid_Current_Password = "Invalid Current Password"
    static let Invalid_New_Password = "Invalid New Password"
    static let Invalid_Confirm_Password = "Invalid Confirm Password"
    static let Please_Wait                 = "Please wait..."
    static let Password_Missmatch          = "Oops! Password miss match... 🤪"
    static let Logout                      = "Logout Successfully...🤚"
    static let Invalid_Latitude            = "Invalid latitude"
    static let Invalid_Longitude           = "Invalid longitude"
    static let Invalid_Address             = "Invalid Address"
    static let Invalid_SelectedAddressType = "Please choose address type"
    static let Invalid_OthersMsg           = "Please give the address type of Others"
    static let Invalid_Strong_Password     = "Password should be at least 6 characters, which Contain At least 1 uppercase, 1 lower case, 1 Numeric digit."
    static let Invalid_OTP                 =  "Invalid OTP"
    static let No_Data_Available           = "No Data Available"
    static let Invalid_Name                = "Invalid Name"
    static let Invalid_Apartmrnt           = "Please enter valid House No/Flat No"
    static let Session_Expired             = "Your session has been expired.Please login again"
}
// MARK : - Arrays
public struct Arrays {
    static let array = ["123","456"]
}
public struct ApiParams  {
    static let Staus_Code        = "statusCode"
    static let Message             = "message"
    static let User_Details      = "userDetails"
    static let Code                   = "code"
}

