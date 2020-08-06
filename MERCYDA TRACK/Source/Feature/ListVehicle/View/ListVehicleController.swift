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
    @IBOutlet weak var noResultStackView: UIStackView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    var listVehicleviewmodel: ListVehicleViewModel?
    var searChedData:[ListVehicleTableViewModel] = []
    var searching:Bool = false
    var vehicleDataSource:[ListVehicleTableViewModel] = []
    var dispatcher: Dispatcher?
    var dispatchGroup: DispatchGroup?
    var vehiclelist = [Vehicle]()
    var type:String?
    
    deinit {
        printLog("ViewController Released from memory : ListVehicleController")
    }
    
    
    
    /// view lifecycle method
    /// - Parameter animated:
    override func viewWillDisappear(_ animated: Bool) {
        self.dispatchGroup = nil
        self.dispatcher = nil
        self.listVehicleviewmodel = nil
    }
    
    
    
    
    /// View lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        listVehicleviewmodel = ListVehicleViewModel()
        mainTableView.register(cellType: VehicleTableViewCell.self)
        refreshDataSource()
        getAllAddress()
        cheeckEmpty()
        setupUi()
        
        
    }
    
    
    func cheeckEmpty(){
        if vehiclelist.count == 0{
            noResultStackView.isHidden = false
            if let vehicleType = type{
            noResultLabel.text = "There are no \(vehicleType) vehicles"
            }
        }else{
            noResultStackView.isHidden = true
        }
    }
    
    
    /// function for setting up intial ui set up
    func setupUi(){
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.007843137255, green: 0.6588235294, blue: 0.862745098, alpha: 1)
        let logo = UIImage.init(named:"logosmall")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .center
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    /// function for getting address of each vehicle in the list
    func getAllAddress(){
        if self.dispatchGroup == nil {
            self.dispatchGroup = DispatchGroup()
        }
        for (index, item) in vehiclelist.enumerated()  {
            if let coordinates =  item.last_updated_data {
                self.getLocationDetails(locationCoordinates: coordinates.coordinates, count: index)
            }
        }
        dispatchGroup?.notify(queue: .main) {
            printLog("Dispatch works completed")
            self.dispatcher = nil
        }
    }
    
    
    /// function  for reloading Tableview
    func refreshDataSource() {
        self.vehicleDataSource.removeAll()
        self.vehicleDataSource.append(ListVehicleTableDataModal.itemsCell(vehicles: vehiclelist))
        self.mainTableView.reloadData()
    }
    
    
    
    /// Function for getting Address of each vehicle
    /// - Parameters:
    ///   - locationCoordinates:latitude and longitude
    ///   - count: index of the corresponding Array
    func getLocationDetails(locationCoordinates: Latlon, count: Int) {
        defer {
            dispatchGroup?.enter()
            self.dispatcher?.getLocationDetails(locationCoordinates: locationCoordinates) { [weak self] (cityAddress) in
                //                  self?.placesArray.append((name: cityAddress, index: count))
                //                  self?.processedResult[count].placeName = cityAddress
                //                  self?.delegate?.reloadData()
                self?.vehiclelist[count].address2 = cityAddress
                self?.refreshDataSource()
                self?.dispatchGroup?.leave()
            }
        }
        guard self.dispatcher != nil else {
            self.dispatcher = Dispatcher()
            return
        }
    }
    
    
    
    
    ///  Function for search buttton Actiom
    /// - Parameter sender:Search button
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
    
    /// Function Cleaar button Action
    /// - Parameter sender:Clear Button
    @IBAction func closeButtonAction(_ sender: Any) {
        searching = false
        mainTableView.reloadData()
        getAllAddress()
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
        
        if searching {
            if  let vehicle =  searChedData[indexPath.section].selectedItemAtIndexPath(indexPath: indexPath) as? Vehicle{
                callViewController(vehicleobj: vehicle)}
        }
        else{
            if  let vehicle =  vehicleDataSource[indexPath.section].selectedItemAtIndexPath(indexPath: indexPath) as? Vehicle{
                callViewController(vehicleobj: vehicle)}
        }
    }
    
    
    
    /// Function for Navigation
    /// - Parameter vehicleobj:the object of the clicked vehicle
    func callViewController(vehicleobj: Vehicle) {
        
        let story = UIStoryboard(name: StoryboardName.VehicleFlow.rawValue, bundle: nil)
        let vehicleFlowVC = story.instantiateViewController(withIdentifier: StoryboardID.VehicleFlow.rawValue)as! VehicleFlowViewController
        vehicleFlowVC.vehicleObj = vehicleobj
        self.navigationController?.pushViewController(vehicleFlowVC, animated: true)
        
    }
    
}


extension ListVehicleController:UITextFieldDelegate{
    
    ///  Textfeild delegate method used for  invoking searching textfeild did chaning editing
    /// - Parameters:
    ///   - textField:
    ///   - range:
    ///   - string: 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        searching = true
        let searchText  = searchTextfeild.text! + string
        searChedData.removeAll()
        listVehicleviewmodel?.searchData(key: searchText, data: vehicleDataSource[0].getVehicleItemCellData()) { (result ) in
            self.searChedData.append(ListVehicleTableDataModal.itemsCell(vehicles: result))
            self.mainTableView.reloadData()
        }
        return true
    }
}


