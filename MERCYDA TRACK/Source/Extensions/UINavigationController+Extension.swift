//
//  UINavigationController+Extension.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /// Pop to Last View Controller
    /// - Parameters:
    ///   - ofClass: class type
    ///   - animated: bool
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let viewController = viewControllers.last(where: {$0.isKind(of: ofClass)}) {
             popToViewController(viewController, animated: animated)
        }
    }
}
