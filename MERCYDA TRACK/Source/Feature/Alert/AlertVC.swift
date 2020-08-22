//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import UIKit

class AlertVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()

    }
    

  func setupUi(){
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.007843137255, green: 0.6588235294, blue: 0.862745098, alpha: 1)
        let logo = UIImage.init(named:"logosmall")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .center
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.image = UIImage.init(named:"refresh")
    }
    
    @objc func addTapped(){
        
    }
}
