//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import UIKit
import MBProgressHUD

class AlertVC: UIViewController {

    @IBOutlet weak var alertTableView: UITableView!
    
    
    // var alertDataSource:[AlertTableViewModel] = []
    let dashboardViewmodel =  DashboardViewModel()
     
     var vehicleDataSource:[AlertTableViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
     //   getAlertData()
         alertTableView.register(cellType: AlertTableVIewCell.self)
        
    }
//    func getAlertData(){
//       MBProgressHUD.showAdded(to: view, animated: true)
//        alertViewModelObj.getAlertData { [weak self] (result) in
//            guard let this = self else {
//                return
//            }
//            MBProgressHUD.hide(for: this.view, animated: false)
//
//           switch result {
//            case .success(let result):
//                this.setDatas(alertDat:result)
//              //  printLog("Vechile details Count \
//            case .failure(let error):
//                statusBarMessage(.CustomError, error)
//                printLog(error)
//            }
//
//        }
//
//    }

//    func setDatas(alertDat:AlertResponse){
//        
//        if let alertDatsource = alertDat.data {
//            self.alertDataSource.append(AlertTableDataModal.itemsCell(alertDat: alertDatsource))
//            self.alertTableView.reloadData()
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        getVehiclesList()
    }
    
    func getVehiclesList(){
        vehicleDataSource.removeAll()
            MBProgressHUD.showAdded(to: view, animated: true)
                   dashboardViewmodel.getVehicleList { [weak self] (result) in
                        guard let this = self else {
                                      return
                                  }
                       MBProgressHUD.hide(for: this.view, animated: false)
                       printLog(result)
                       switch result{
                           
                           case .success(let result):
                                this.dashboardViewmodel.filterAlertData(data: result) {  (filterdResult ) in
                                    this.vehicleDataSource.append(AlertTableDataModal.itemsCell(alertDat: filterdResult))
                                    this.alertTableView.reloadData()
                                           
                        }
                         
                           case .failure(let error) :
                           MBProgressHUD.hide(for: this.view, animated: false)
                           printLog(error)
                       }
           }
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
    func navigatetoAlertDetail(vehicleObj:Vehicle){
        let story = UIStoryboard(name: StoryboardName.Alerts.rawValue, bundle: nil)
        let vehicleFlowVC = story.instantiateViewController(withIdentifier: StoryboardID.AlertDetail.rawValue)as! AlertDetailController
        vehicleFlowVC.vehicleObj = vehicleObj
        self.navigationController?.pushViewController(vehicleFlowVC, animated: true)
    }
}


extension AlertVC:UITableViewDataSource,UITableViewDelegate,AlertViewControllerGenericDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vehicleDataSource.count != 0{
        let section = vehicleDataSource[section]
        return section.numberOfRowsInSection()
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let list = vehicleDataSource[indexPath.section]
        //  return list.getCellForRow(tableView: tableView, delegate: self, indexPath: indexPath)
        return list.getCellForRowsInSection(tableView:tableView, delegateClass: self, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let vehicle =  vehicleDataSource[indexPath.section].selectedItemAtIndexPath(indexPath: indexPath) as? Vehicle{
            vehicleNumber = vehicle.vehicle_registration!
            
            navigatetoAlertDetail(vehicleObj:vehicle)
        }
    }
}
