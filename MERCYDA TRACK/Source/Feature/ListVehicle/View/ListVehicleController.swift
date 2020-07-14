//
//  ListVehicleController.swift
//  MERCYDA TRACK
//
//  Created by Tony on 07/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

class ListVehicleController: BaseViewController {

    @IBOutlet weak var searchTextfeild: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var serachView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    var listVehicleviewmodel = ListVehicleViewModel()
    var searChedData:[ListVehicleTableViewModel] = []
    var searching:Bool = false
    var vehicleDataSource:[ListVehicleTableViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.register(cellType: VehicleTableViewCell.self)
        print(vehicleDataSource.count)
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.007843137255, green: 0.6588235294, blue: 0.862745098, alpha: 1)
        let logo = UIImage.init(named:"logosmall")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .center
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.tintColor = .white
    }
    override func viewWillLayoutSubviews() {
        
    }

    @IBAction func searchButtonAction(_ sender: Any) {
        if serachView.isHidden == true{
            serachView.isHidden = false
            serachView.addBottomBorderWithColor(color:UIColor.lightGray, width: 0.5)
            searchButton.isHidden = true
            searchTextfeild.withImage(direction:.Left, image: UIImage.init(named:"searchlight")!, colorSeparator:UIColor.clear, colorBorder: UIColor.clear)
        }else{
            serachView.isHidden = true
        }
        
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        searching = false
        mainTableView.reloadData()
        if serachView.isHidden == false{
            serachView.isHidden = true
            searchButton.isHidden = false
            searchTextfeild.text = ""
        }else{
            serachView.isHidden = false
            searchButton.isHidden = true
        }
    }
   
    
    
    
}


extension ListVehicleController:UITableViewDelegate,UITableViewDataSource,ListVehicleViewControllerGenericDelegate{
  
   
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return vehicleDataSource.count
        if searching{
      let section = searChedData[section]
     return section.numberOfRowsInSection()
        }
        else{
            let section = vehicleDataSource[section]
            return section.numberOfRowsInSection()
        }
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          // let list = vehicleDataSource[indexPath.row]
        if searching{
            let list = searChedData[indexPath.section]
         //  return list.getCellForRow(tableView: tableView, delegate: self, indexPath: indexPath)
         
           
        return list.getCellForRowsInSection(tableView:tableView, delegateClass: self, indexPath: indexPath)
        }
        else{
            let list = vehicleDataSource[indexPath.section]
             //  return list.getCellForRow(tableView: tableView, delegate: self, indexPath: indexPath)
            return list.getCellForRowsInSection(tableView:tableView, delegateClass: self, indexPath: indexPath)
        }
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let vehicle =  vehicleDataSource[indexPath.section].selectedItemAtIndexPath(indexPath: indexPath) as? Vehicle{
//            printLog(vehicle.vehicle_registration!)
//            printLog(vehicle.last_updated_data!.serial_no!)
            callViewController(serialNo: vehicle.last_updated_data?.serial_no ?? "InvalidSerialNo")
        }
    }
    
    func callViewController(serialNo: String) {
        let story = UIStoryboard(name: StoryboardName.VehicleFlow.rawValue, bundle: nil)
        let vehicleFlowVC = story.instantiateViewController(withIdentifier: StoryboardID.VehicleFlow.rawValue)as! VehicleFlowViewController
        vehicleFlowVC.serialNumber = serialNo
        self.navigationController?.pushViewController(vehicleFlowVC, animated: true)
        
    }
    
}


extension ListVehicleController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        searching = true
        let searchText  = searchTextfeild.text! + string
         searChedData.removeAll()
           listVehicleviewmodel.searchData(key: searchText, data: vehicleDataSource[0].getVehicleItemCellData()) { (result ) in
            self.searChedData.append(ListVehicleTableDataModal.itemsCell(vehicles: result))
            self.mainTableView.reloadData()
        }
         return true
    }
}
