//
//  LoginTableviewCell.swift
//  MERCYDA TRACK
//
//  Created by Tony on 30/06/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

class LoginTableviewCell: UITableViewCell {

    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var usernameVIew: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameTextfeild: UITextField!
    @IBOutlet weak var passwordTextfeild: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
    logoView.roundCorners(.allCorners, radius: 15)
    usernameVIew.addBorder(color:UIColor.lightGray, borderwidth: 1.5)
    passwordView.addBorder(color:UIColor.lightGray, borderwidth: 1.5)
    loginButton.roundCorners(.allCorners, radius: 15)
    logoImageView.roundCorners([.bottomLeft,.bottomRight], radius: 20)
    }
    
   
}
