//
//  LoginViewController.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: BaseViewController {
    @IBOutlet weak var topBackgroundImage: UIImageView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userNameTextfeild: UITextField!
    @IBOutlet weak var passwordTextfeild: UITextField!
    var emailText :String? = nil
    private let networkServiceCalls = NetworkServiceCalls()
    let loginViewmodel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
     
        
    }
    
    override func viewWillLayoutSubviews() {
    topBackgroundImage.roundCorners([.bottomRight,.bottomLeft], radius: 20)
    logoView.roundCorners(.allCorners, radius: 20)
    userNameView.addBorder(color:UIColor.lightGray, borderwidth: 1)
    passwordView.addBorder(color:UIColor.lightGray, borderwidth: 1)
    loginButton.roundCorners(.allCorners, radius: 10)
    }

    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        
        self.showAlert(title:MessageConstants.ForgotPasswordTitle.rawValue, message: MessageConstants.ForotPasswordMessage.rawValue)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
         guard validateData() else {return}
        MBProgressHUD.showAdded(to: view, animated: true)
        loginViewmodel.loginUser(withEmail: self.userNameTextfeild.text!, password: self.passwordTextfeild.text!) { [weak self] (result) in
            guard let this = self else {
                return
            }
         MBProgressHUD.hide(for: this.view, animated: false)
            switch result {
            case .success(let result):
            printLog(result)
            let story = UIStoryboard(name: StoryboardName.Dashboard.rawValue, bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: StoryboardID.DashboardId.rawValue)as! DashboardViewController
            self?.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                statusBarMessage(.CustomError, error.localizedDescription)
                printLog(error.localizedDescription)
            }
        }
          
    }
    
    
    
    func validateData() -> Bool {
          emailText = userNameTextfeild.text!
           guard !userNameTextfeild.text!.isEmptyStr else{
            userNameTextfeild.placeholder = MessageConstants.EmptyUserName.rawValue
              Utility.errorTextFiled(userNameTextfeild)
               return false
           }
           guard userNameTextfeild.text!.isValidEmail else {
               userNameTextfeild.text = nil
            userNameTextfeild.placeholder = MessageConstants.InvalidEmail.rawValue
               Utility.errorTextFiled( userNameTextfeild)
               return false
           }
           guard !passwordTextfeild.text!.isEmptyStr else {
            passwordTextfeild.placeholder = MessageConstants.EmptyPasswordErrorMessage.rawValue
               Utility.errorTextFiled(passwordTextfeild)
               return false
           }
           return true
           
       }
}


extension LoginViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
       // textField.placeHolderColor = UIColor.black
        textField.textFieldBorderColor = UIColor.clear
        if textField == self.userNameTextfeild{
            textField.placeholder = "Username"
            if let text = emailText{
                textField.text = text
                emailText = nil
            }
        }
        
        if textField == self.passwordTextfeild{
            textField.placeholder = "Password"
        }
        
    }
}
