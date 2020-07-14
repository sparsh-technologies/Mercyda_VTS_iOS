//
//  BaseViewController.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import SwiftMessages
import MBProgressHUD

/// Base ViewController for all ViewController
class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    let activityIndicator = MBProgressHUD()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        statusBarColor()
        configureUI()
    }
}

extension BaseViewController {
    
    /// Show Alert with Actions
    /// - Parameters:
    ///   - title: String type
    ///   - message: String type
    ///   - options: Button name in String
    ///   - completion: Return Selected Action
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { _ in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Show Alert with Title
    /// - Parameters:
    ///   - title: String type
    ///   - message: String Type
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /// Set Theme
    func setDarkTheme() {
        Theme.darkTheme()
    }
    
    /// Set Default Theme
    func setDefaultTheme() {
        Theme.defaultTheme()
    }
    
    func setBackGroungColor(_ rgb: Int) -> UIColor {
        return UIColor(hex: rgb)
    }
    
    /// Hide Keyboard
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    /// Setup initial UI
    func configureUI() {
        self.view.backgroundColor = UIColor.init(named: "ThemeBlue")
    }
    
    /// Custom StatusBar Colour
    func statusBarColor() {
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor(named: "ThemeBlue")
            view.addSubview(statusbarView)
            
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
         //   statusBar?.backgroundColor = UIColor.red
             statusBar?.backgroundColor = UIColor(named: "ThemeBlue")
        }
        
    }
}

public enum MessageType: String {
    case ApprovalType = "Approval"
    case HoldType     = "Hold"
    case SuggestType  = "Suggest"
    case DeclineType  = "Decline"
    case InvalidCredentials = "InvalidCredentials"
    case CustomError = "CustomError"
    case CustomSuccess = "CustomSuccess"
}


//extension UIViewController {
func statusBarMessage(_ messageType: MessageType, _ message: String) {
    let warning = MessageView.viewFromNib(layout: .cardView)
    warning.configureTheme(.warning)
    warning.configureDropShadow()
    warning.configureTheme(backgroundColor: .white, foregroundColor: .darkGray)
    let iconText = "⁉️"
    warning.configureContent(title: "Warning", body: "Consider yourself warned.", iconText: iconText)
    warning.button?.isHidden = true
    var warningConfig = SwiftMessages.defaultConfig
    warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
    let success = MessageView.viewFromNib(layout: .cardView)
    success.configureTheme(.success)
    success.configureDropShadow()
    success.configureContent(title: "Success", body: "Your request processed successfully!")
    success.button?.isHidden = true
    
    var successConfig = SwiftMessages.defaultConfig
    successConfig.presentationStyle = .center
    successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
    let successWithCustomMsg = MessageView.viewFromNib(layout: .cardView)
    successWithCustomMsg.configureTheme(.success)
    successWithCustomMsg.configureDropShadow()
    successWithCustomMsg.configureContent(title: "Success", body: message)
    successWithCustomMsg.button?.isHidden = true
    var successConfigWithCustomMsg = SwiftMessages.defaultConfig
    successConfigWithCustomMsg.presentationStyle = .center
    successConfigWithCustomMsg.presentationContext = .window(windowLevel: UIWindow.Level.normal)
    
    switch messageType {
    case .ApprovalType:
        SwiftMessages.show(config: successConfig, view: success)
    case .DeclineType:
        SwiftMessages.show(config: successConfig, view: success)
    case .HoldType:
        SwiftMessages.show(config: successConfig, view: success)
    case .SuggestType:
        SwiftMessages.show(config: successConfig, view: success)
    case .InvalidCredentials:
        warning.configureContent(title: "Invalid Credentials", body: "Check your username or password", iconText: iconText)
        SwiftMessages.show(config: warningConfig, view: warning)
    case .CustomError:
        warning.configureContent(title: "Something Went Wrong!", body: message, iconText: iconText)
        SwiftMessages.show(config: warningConfig, view: warning)
    case .CustomSuccess:
        SwiftMessages.show(config: successConfigWithCustomMsg, view: successWithCustomMsg)
    }
}
