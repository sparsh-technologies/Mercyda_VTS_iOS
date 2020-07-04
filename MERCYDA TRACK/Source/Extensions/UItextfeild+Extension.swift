//
//  UItextfeild+Extension.swift
//  MERCYDA TRACK
//
//  Created by Tony on 04/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import UIKit


extension UITextField{

@IBInspectable var placeHolderColor: UIColor?{
    get {
        return self.placeHolderColor
    }
    set {
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
    }
}
@IBInspectable var textFieldBorderColor: UIColor? {
    get {
        return UIColor(cgColor: layer.borderColor!)
    }
    set {
        layer.borderColor = newValue?.cgColor
    }
}
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    
    func addBottomborder(color:UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 2.0)
        bottomLine.backgroundColor = color.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
}

