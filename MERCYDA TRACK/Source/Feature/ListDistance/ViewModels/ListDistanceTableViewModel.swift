//
//  ListDistanceTableViewModel.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 05/07/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import UIKit

protocol ListDistanceViewControllerGenericDelegate {
    
}

protocol ListDistanceTableViewModel {
    func numberOfRowsInSection() -> Int
    func getHeaderForSection<T:ListDistanceViewControllerGenericDelegate>(tableView: UITableView, delegateClass: T,section: Int) -> UITableViewHeaderFooterView
    func getCellForRowsInSection<T:ListDistanceViewControllerGenericDelegate>(tableView: UITableView, delegateClass: T, indexPath: IndexPath) -> UITableViewCell
    func heightForHeaderInSection(section: Int) -> CGFloat
    func heightForFooterInSection(section: Int) -> CGFloat
    func selectedItemAtIndexPath(indexPath: IndexPath) -> Any?
}

enum ListDistanceTableDataModal {
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


extension ListDistanceTableDataModal: ListDistanceTableViewModel {
   
    
    func selectedItemAtIndexPath(indexPath: IndexPath) -> Any? {
        switch self {
        case .itemsCell(vehicles: let vehiclesArray):
            return vehiclesArray[indexPath.row]
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
    
    func getHeaderForSection<T>(tableView: UITableView, delegateClass: T, section: Int) -> UITableViewHeaderFooterView where T : ListDistanceViewControllerGenericDelegate {
        switch self {
        case .itemsCell(vehicles: let vehiclesArray):
            guard let vehicleHeaderCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchCategoryNotificationCell.reuseIdentifier") as? UITableViewHeaderFooterView else {
                return UITableViewHeaderFooterView()
            }
            return vehicleHeaderCell
        }
    }
    
    func getCellForRowsInSection<T>(tableView: UITableView, delegateClass: T, indexPath: IndexPath) -> UITableViewCell where T : ListDistanceViewControllerGenericDelegate {
        switch self {
            
        case .itemsCell(vehicles: let vehiclesArray):
            guard let vehicleCell = tableView.dequeueReusableCell(withIdentifier: "vehicleCell", for: indexPath) as? UITableViewCell else {
                return UITableViewCell()
            }
            return vehicleCell
        }
    }
}
