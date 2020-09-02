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
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
              self.clipsToBounds = true
            self.layer.mask = mask
        }
      
    }
    func addShadow(customView: UIView) {
        customView.layer.shadowPath =
              UIBezierPath(roundedRect: customView.bounds,
              cornerRadius:customView.layer.cornerRadius).cgPath
        customView.layer.shadowColor = UIColor.black.cgColor
        customView.layer.shadowOpacity = 0.5
        customView.layer.shadowOffset = CGSize(width: 2, height: 2)
        customView.layer.shadowRadius = 1
        customView.layer.masksToBounds = false
    }
    
    func addBorder(color:UIColor,borderwidth:CGFloat){
        self.layer.borderWidth = borderwidth
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
          let border = CALayer()
          border.backgroundColor = color.cgColor
          border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
          self.layer.addSublayer(border)
      }
    func aspectRatio(_ ratio: CGFloat) -> NSLayoutConstraint {
           return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
       }

   func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
     
       let gradientLayer = CAGradientLayer()
       
       gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
       let width = UIScreen.main.bounds.width
       let ht = self.frame.height
       let x = self.frame.origin.x
       let y = self.frame.origin.y
       gradientLayer.frame = CGRect(x: x, y: 0, width: width, height: ht)
       gradientLayer.frame = self.bounds
      // gradientLayer.startPoint = CGPoint(x: 0, y: 0)
       //gradientLayer.endPoint = CGPoint(x: 1, y: 1)
     gradientLayer.startPoint = CGPoint(x:0 , y: 0)
      gradientLayer.endPoint = CGPoint(x: 0, y: 1)
       self.layer.insertSublayer(gradientLayer, at: 0)
   }
    
}
