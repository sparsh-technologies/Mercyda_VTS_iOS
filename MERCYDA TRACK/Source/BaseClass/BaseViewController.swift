//
//  BaseViewController.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import SwiftMessages

/// Base ViewController for all ViewController
class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
   
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
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
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor]
        gradient.locations = [0, 1]
        view.layer.insertSublayer(gradient, at: 0)
        gradient.frame = view.frame
    }
}

extension BaseViewController {
    
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
            warning.configureContent(title: "", body: message, iconText: iconText)
            SwiftMessages.show(config: warningConfig, view: warning)
        case .CustomSuccess:
            SwiftMessages.show(config: successConfigWithCustomMsg, view: successWithCustomMsg)
        }
    }