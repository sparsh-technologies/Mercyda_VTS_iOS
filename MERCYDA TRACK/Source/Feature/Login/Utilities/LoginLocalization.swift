//
//  LoginLocalization.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

/// Login Localization
enum LoginLocalization: String, Localizable {
    case forget_password = "forget_password"
    case enter_email = "enter_email"
    case cancel = "cancel"
    case ok = "ok"
    case password_reset = "password_reset"
    case check_email = "tcheck_email"
    case invalid_form = "invalid_form"
    case password_incorrect = "password_incorrect"
    case login = "login"
    case signup = "signup"
    case email = "email"
    case password = "password"
    case confirm_password = "confirm_password"
    case loginError = "Something went wrong"
    case loginErrorMessage = "Do you want to continue without SignIn"
}



enum userDefaultKeys:String{
    case userLoginInfo = "userLogionDetails"
    case userName = "userName"
    case passWord = "passWord"
    case isLogin = "isLogin"
}
