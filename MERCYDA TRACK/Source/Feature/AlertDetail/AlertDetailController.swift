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
    @IBOutlet weak var mainpowerOffView: UIView!
    @IBOutlet weak var wireCutAlertView: UIView!
    @IBOutlet weak var emergencyAlertView: UIView!
    @IBOutlet weak var overspeedAlertView: UIView!
    
    @IBOutlet weak var mainPowerAlertlabel: UILabel!
    @IBOutlet weak var wirecutAlertLabel: UILabel!
    @IBOutlet weak var emergencyAlertLabel: UILabel!
    @IBOutlet weak var overspeedAlertLabel: UILabel!
    
    @IBOutlet weak var alertDetailTableView: UITableView!
    
    var vehicleObj:Vehicle?
    let alertViewModelObj = AlertViewModel()
    var alertDataSource:[AlertDetailTableViewModel] = []
    var dispatcher: Dispatcher?
    var dispatchGroup: DispatchGroup?
    var alertDat = [AlertData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUi()
        self.setDatas()
        getAlertData()
        alertDetailTableView.register(cellType: AlertDetailTableViewCell.self)
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
      alertcountView.layer.cornerRadius = alertcountView.frame.height/2
      alertcountView.clipsToBounds = true
    }
    func setDatas(){
    self.vehiclenumberLabel.text = vehicleObj?.vehicle_registration
    if let vehicleType = vehicleObj?.vehicle_type{
        getVehicleType(type:vehicleType)
    }
    
    let mainPoweralertCount = vehicleObj?.main_power_removal_alert_count ?? 0
    mainpowerOffView.isHidden = mainPoweralertCount == 0
    mainPowerAlertlabel.text = "\(mainPoweralertCount)"
    let wirecutAlert = vehicleObj?.wire_cut_alert_count ?? 0
    wireCutAlertView.isHidden = wirecutAlert == 0
    wirecutAlertLabel.text = "\(wirecutAlert)"
    let emergencyAlert = vehicleObj?.emergency_alert_count ?? 0
    emergencyAlertView.isHidden = emergencyAlert == 0
    emergencyAlertLabel.text = "\(emergencyAlert)"
    let overspeed = vehicleObj?.overspeed_alert_count ?? 0
    overspeedAlertView.isHidden = overspeed == 0
    overspeedAlertLabel.text = "\(overspeed)"
    let totalAlertCount = mainPoweralertCount + wirecutAlert + emergencyAlert + overspeed
    alertCounttable.text = "\(totalAlertCount)"
    
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
                    this.setDatas(alertresponse:result)
                  //  printLog("Vechile details Count \
                case .failure(let error):
                    statusBarMessage(.CustomError, error)
                    printLog(error)
                }
    
            }
    
        }

        func setDatas(alertresponse:AlertResponse){
    
            if let alertdetaildaatsource = alertresponse.data {
                
                alertDat = alertdetaildaatsource
             //   refreshDataSource()
                getAllAddress()
               
                print(alertdetaildaatsource)
                //self.alertDetailTableView.reloadData()
            }
        }
    
    func getAllAddress(){
          if self.dispatchGroup == nil {
              self.dispatchGroup = DispatchGroup()
          }
          for (index, item) in alertDat.enumerated()  {
            printLog(item.d?.coordinates)
            self.getLocationDetails(locationCoordinates: item.d!.coordinates, count: index)

          }
          dispatchGroup?.notify(queue: .main) {
              printLog("Dispatch works completed")
              self.dispatcher = nil
          }
      }
    
    func getLocationDetails(locationCoordinates: Latlon, count: Int) {
           defer {
               dispatchGroup?.enter()
               self.dispatcher?.getLocationDetails(locationCoordinates: locationCoordinates) { [weak self] (cityAddress) in
                   //                  self?.placesArray.append((name: cityAddress, index: count))
                   //                  self?.processedResult[count].placeName = cityAddress
                   //                  self?.delegate?.reloadData()
                printLog(cityAddress)
                   self?.alertDat[count].address2 = cityAddress
                   self?.refreshDataSource()
                   self?.dispatchGroup?.leave()
               }
           }
           guard self.dispatcher != nil else {
               self.dispatcher = Dispatcher()
               return
           }
       }
    
    func refreshDataSource() {
        DispatchQueue.main.async {
            self.alertDataSource.removeAll()
            self.alertDataSource.append(AlertDetailTableDataModal.itemsCell(alertDat: self.alertDat))
            self.alertDetailTableView.reloadData()
        }
     
    }
    override func viewWillDisappear(_ animated: Bool) {
          self.dispatchGroup = nil
          self.dispatcher = nil
          
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


extension AlertDetailController :UITableViewDataSource,UITableViewDelegate,AlertDetailControllerGenericDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if alertDataSource.count != 0{
            let section = alertDataSource[section]
            return section.numberOfRowsInSection()
        }
        else {
            return 0
        }
              
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = alertDataSource[indexPath.section]
       return list.getCellForRowsInSection(tableView:tableView, delegateClass: self, indexPath: indexPath)
    }
    
}
