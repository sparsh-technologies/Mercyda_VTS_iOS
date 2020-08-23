//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import UIKit

class AlertVC: UIViewController {

     let alertViewModelObj = AlertViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        getAlertData()
        

    }
    func getAlertData(){
       MBProgressHUD.showAdded(to: view, animated: true)
        alertViewModelObj.getAlertData { [weak self] (result) in
            guard let this = self else {
                return
            }
            MBProgressHUD.hide(for: this.view, animated: false)

           switch result {
            case .success(let result):
                this.setDatas(alertDat:result)
              //  printLog("Vechile details Count \(result)")
            case .failure(let error):
                statusBarMessage(.CustomError, error)
                printLog(error)
            }

        }
       
    }

    func setDatas(alertDat:AlertResponse){
        print(alertDat.data?.count)
        print(alertDat.data![0].id)
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
