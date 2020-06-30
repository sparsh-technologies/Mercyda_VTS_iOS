//
//  UIView+Extension.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Load View From Nib
    /// - Parameters:
    ///   - nibName: String
    ///   - bundle: Bundle type
    func loadViewFromNib(nibName: String, bundle: Bundle = Bundle.main) -> UIView {
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
    
    /// Custom SubView
    /// - Parameter subView: UIView Type
    func addCustomSubview(subView: UIView?) {
        guard let view = subView else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
