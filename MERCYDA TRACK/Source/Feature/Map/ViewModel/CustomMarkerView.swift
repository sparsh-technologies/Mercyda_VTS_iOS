//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import UIKit

class CustomMarkerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let placeOrderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.init(named: "h_pin")
        return imageView
    }()
    
     init(frame: CGRect = CGRect(),image : UIImage) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        placeOrderImageView.image = image
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(placeOrderImageView)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 35),
            placeOrderImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            placeOrderImageView.heightAnchor.constraint(equalToConstant: 35),
            placeOrderImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        placeOrderImageView.aspectRatio(1.0/1.0).isActive = true
        self.aspectRatio(1.0/1.0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fly() {
        let flyAnim = CABasicAnimation(keyPath: "position")
        flyAnim.duration = 3.6
        flyAnim.repeatCount = 0
        flyAnim.autoreverses = false
        flyAnim.fromValue = NSValue(cgPoint: CGPoint.init(x: self.center.x - 100, y: self.center.y - 100))
        flyAnim.toValue = NSValue(cgPoint: CGPoint.init(x: self.center.x + 100, y: self.center.y + 100))
        self.layer.add(flyAnim, forKey: "position")
    }

}
