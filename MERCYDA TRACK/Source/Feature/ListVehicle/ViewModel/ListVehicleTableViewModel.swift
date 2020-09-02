//
//  ListVehicleTableViewModel.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 05/07/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import UIKit

protocol ListVehicleViewControllerGenericDelegate {
    
}

protocol ListVehicleTableViewModel {
    func numberOfRowsInSection() -> Int
    func getHeaderForSection<T:ListVehicleViewControllerGenericDelegate>(tableView: UITableView, delegateClass: T,section: Int) -> UITableViewHeaderFooterView
    func getCellForRowsInSection<T:ListVehicleViewControllerGenericDelegate>(tableView: UITableView, delegateClass: T, indexPath: IndexPath) -> UITableViewCell
    func heightForHeaderInSection(section: Int) -> CGFloat
    func heightForFooterInSection(section: Int) -> CGFloat
    func selectedItemAtIndexPath(indexPath: IndexPath) -> Any?
    func getVehicleItemCellData() -> [Vehicle]
}

enum ListVehicleTableDataModal {
    case itemsCell(vehicles: [Vehicle])
    
    var numberOfRows : Int {
        get {
            switch self {
            case .itemsCell(vehicles: let vehiclesArray):
                return vehiclesArray.count
            }
        }
    }
}


extension ListVehicleTableDataModal: ListVehicleTableViewModel {
    func selectedItemAtIndexPath(indexPath: IndexPath) -> Any? {
        switch self {
        case .itemsCell(vehicles: let vehiclesArray):
            return vehiclesArray[indexPath.row]
        }
    }
    
    func getVehicleItemCellData() -> [Vehicle]{
        switch self {
              case .itemsCell(vehicles: let vehiclesArray):
                  return vehiclesArray
              }
    }
    
    func heightForHeaderInSection(section: Int) -> CGFloat {
        switch self {
        case .itemsCell:
            return UITableView.automaticDimension
        }
    }
    
    func heightForFooterInSection(section: Int) -> CGFloat {
        switch self {
        case .itemsCell:
            return UITableView.automaticDimension
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return numberOfRows
    }
    
    func getHeaderForSection<T>(tableView: UITableView, delegateClass: T, section: Int) -> UITableViewHeaderFooterView where T : ListVehicleViewControllerGenericDelegate {
        switch self {
        case .itemsCell(vehicles: let vehiclesArray):
            guard let vehicleHeaderCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchCategoryNotificationCell.reuseIdentifier") as? UITableViewHeaderFooterView else {
                return UITableViewHeaderFooterView()
            }
            return vehicleHeaderCell
        }
    }
    
    func getCellForRowsInSection<T>(tableView: UITableView, delegateClass: T, indexPath: IndexPath) -> UITableViewCell where T : ListVehicleViewControllerGenericDelegate {
        switch self {
            
        case .itemsCell(vehicles: let vehiclesArray):
            guard let vehicleCell = tableView.dequeueReusableCell(withIdentifier: "VehicleTableViewCell", for: indexPath) as? VehicleTableViewCell else {
                return UITableViewCell()
            }
           
            vehicleCell.setVehicleData(vehicle:vehiclesArray[indexPath.row])
           
          
            return vehicleCell
        }
    }
    
    
}


enum VehicleModel:String{
    case Lorry = "LORRY"
    case MiniTruck = "MINI TRUCK"
    case Car = "CAR"
     
}
enum VehicleMode :String{
    case Moving = "M"
    case Sleep = "S"
    case Idle = "H"
    case Offline = "OFFLINE"
}

enum IgnitionType:String{
    case OFF = "OFF"
    case ON = "ON"
}
