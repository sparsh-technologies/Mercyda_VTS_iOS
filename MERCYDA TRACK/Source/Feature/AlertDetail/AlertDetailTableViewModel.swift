//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import Foundation
import UIKit

protocol AlertDetailControllerGenericDelegate {
    
}

protocol AlertDetailTableViewModel {
    func numberOfRowsInSection() -> Int
    func getHeaderForSection<T:AlertDetailControllerGenericDelegate>(tableView: UITableView, delegateClass: T,section: Int) -> UITableViewHeaderFooterView
    func getCellForRowsInSection<T:AlertDetailControllerGenericDelegate>(tableView: UITableView, delegateClass: T, indexPath: IndexPath) -> UITableViewCell
    func heightForHeaderInSection(section: Int) -> CGFloat
    func heightForFooterInSection(section: Int) -> CGFloat
    func selectedItemAtIndexPath(indexPath: IndexPath) -> Any?
}

enum AlertDetailTableDataModal {
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


extension AlertDetailTableDataModal: AlertDetailTableViewModel {
  
    
    func selectedItemAtIndexPath(indexPath: IndexPath) -> Any? {
        switch self {
        case .itemsCell(alertDat: let alertArray):
            return alertArray[indexPath.row]
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
    
    func getHeaderForSection<T>(tableView: UITableView, delegateClass: T, section: Int) -> UITableViewHeaderFooterView where T : AlertDetailControllerGenericDelegate {
        switch self {
        case .itemsCell(alertDat: let alertArray):
            guard let vehicleHeaderCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchCategoryNotificationCell.reuseIdentifier") as? UITableViewHeaderFooterView else {
                return UITableViewHeaderFooterView()
            }
            return vehicleHeaderCell
        }
    }
    
    func getCellForRowsInSection<T>(tableView: UITableView, delegateClass: T, indexPath: IndexPath) -> UITableViewCell where T : AlertDetailControllerGenericDelegate {
        switch self {
            
        case .itemsCell(alertDat: let alertArray):
            guard let alertCell = tableView.dequeueReusableCell(withIdentifier: "AlertDetailTableViewCell", for: indexPath) as? AlertDetailTableViewCell else {
                
                return UITableViewCell()
            }
            
            alertCell.setDatas(alertDat: alertArray[indexPath.row])
           
            return alertCell
        }
    }
}
