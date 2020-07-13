//
//  Aboutuscontroller.swift
//  MERCYDA TRACK
//
//  Created by Tony on 12/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

class Aboutuscontroller: UIViewController {

   
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var contactusView: UIView!
    @IBOutlet weak var websiteView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isHidden = false
    navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.007843137255, green: 0.6588235294, blue: 0.862745098, alpha: 1)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        websiteView.roundCorners(.allCorners, radius: 15)
        contactusView.roundCorners([.topLeft,.topRight], radius: 15)
        termsAndConditionView.roundCorners([.bottomLeft,.bottomRight], radius: 15)
    
    }
    
    
  
}
