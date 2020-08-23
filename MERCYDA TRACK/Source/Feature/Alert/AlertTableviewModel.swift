//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  


import Foundation
import UIKit

protocol AlertViewControllerGenericDelegate {
    
}

protocol AlertTableViewModel {
    func numberOfRowsInSection() -> Int
    func getHeaderForSection<T:AlertViewControllerGenericDelegate>(tableView: UITableView, delegateClass: T,section: Int) -> UITableViewHeaderFooterView
    func getCellForRowsInSection<T:AlertViewControllerGenericDelegate>(tableView: UITableView, delegateClass: T, indexPath: IndexPath) -> UITableViewCell
    func heightForHeaderInSection(section: Int) -> CGFloat
    func heightForFooterInSection(section: Int) -> CGFloat
    func selectedItemAtIndexPath(indexPath: IndexPath) -> Any?
}

enum AlertTableDataModal {
    case itemsCell(alertDat: [AlertData])
    
    var numberOfRows : Int {
        get {
            switch self {
            case .itemsCell(alertDat: let alertArray):
                return alertArray.count
            }
        }
    }
}


extension AlertTableDataModal: AlertTableViewModel {
  
    
    func selectedItemAtIndexPath(indexPath: IndexPath) -> Any? {
        switch self {
        case .itemsCell(alertDat: let vehiclesArray):
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
    
    func getHeaderForSection<T>(tableView: UITableView, delegateClass: T, section: Int) -> UITableViewHeaderFooterView where T : AlertViewControllerGenericDelegate {
        switch self {
        case .itemsCell(alertDat: let vehiclesArray):
            guard let vehicleHeaderCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchCategoryNotificationCell.reuseIdentifier") as? UITableViewHeaderFooterView else {
                return UITableViewHeaderFooterView()
            }
            return vehicleHeaderCell
        }
    }
    
    func getCellForRowsInSection<T>(tableView: UITableView, delegateClass: T, indexPath: IndexPath) -> UITableViewCell where T : AlertViewControllerGenericDelegate {
        switch self {
            
        case .itemsCell(alertDat: let vehiclesArray):
            guard let vehicleCell = tableView.dequeueReusableCell(withIdentifier: "vehicleCell", for: indexPath) as? UITableViewCell else {
                return UITableViewCell()
            }
            return vehicleCell
        }
    }
}
