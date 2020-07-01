//
//  UItableViewExtension.swift
//  TestProjectApp
//
//  Created by Tony on 08/04/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: Bundle(for: T.self))
        register(nib, forCellReuseIdentifier: className)
    }
    func horizontalAnimation() {
        self.reloadData()
        let cells = self.visibleCells
        let tableWidth: CGFloat = self.bounds.size.width
        for cell in cells {
            let cell: UITableViewCell = cell as UITableViewCell
            cell.transform = CGAffineTransform(translationX: tableWidth, y: 0)
        }
        var index = 0
        for cell in cells {
            let cell: UITableViewCell = cell as UITableViewCell
            UIView.animate(withDuration: 1.5,
                           delay: 0.05 * Double(index),
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: [.curveEaseIn],
                           animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }
}
