//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import UIKit
import MBProgressHUD

class AlertDetailController: UIViewController {

    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var vehiclenumberLabel: UILabel!
    @IBOutlet weak var alertCounttable: UILabel!
    @IBOutlet weak var alertcountView: UIView!
    
    var vehicleObj:Vehicle?
    let alertViewModelObj = AlertViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUi()
        getAlertData()
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
    
    self.vehiclenumberLabel.text = vehicleObj?.vehicle_registration
    //getVehicleType(type:(vehicleObj?.vehicle_type!)!)
    if let vehicleType = vehicleObj?.vehicle_type{
        getVehicleType(type:vehicleType)
    }
    if let alertCOunt = vehicleObj?.alert_count{
        alertCounttable.text = "\(alertCOunt)"
    }
    
    alertcountView.layer.cornerRadius = alertcountView.frame.height/2
    alertcountView.clipsToBounds = true
    
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
                  //  printLog("Vechile details Count \
                case .failure(let error):
                    statusBarMessage(.CustomError, error)
                    printLog(error)
                }
    
            }
    
        }

        func setDatas(alertDat:AlertResponse){
    
            if let alertDatsource = alertDat.data {
               // self.alertDataSource.append(AlertTableDataModal.itemsCell(alertDat: alertDatsource))
               // self.alertTableView.reloadData()
                print(alertDatsource)
            }
        }
    
    
    func getVehicleType(type:String){
             switch type{
             case VehicleModel.Lorry.rawValue:
                 self.vehicleImage.image = UIImage.init(named:"Lorry")
             case VehicleModel.MiniTruck.rawValue:
                 self.vehicleImage.image = UIImage.init(named: "minilorry")
             case VehicleModel.Car.rawValue:
                 self.vehicleImage.image = UIImage.init(named: "car")
             default:
                 self.vehicleImage.image = UIImage.init(named:"Lorry")
             }
         }
    @objc func addTapped(){
        
    }
}
