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
        let section = vehicleDataSource[section]
        return section.numberOfRowsInSection()
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          // let list = vehicleDataSource[indexPath.row]
            let list = vehicleDataSource[indexPath.section]
         //  return list.getCellForRow(tableView: tableView, delegate: self, indexPath: indexPath)
        return list.getCellForRowsInSection(tableView:tableView, delegateClass: self, indexPath: indexPath)
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let vehicle =  vehicleDataSource[indexPath.section].selectedItemAtIndexPath(indexPath: indexPath) as? Vehicle{
            printLog(vehicle.vehicle_registration!)
            printLog(vehicle.last_updated_data!.serial_no!)
        }
        
       
       
    }
    
    
    
}
