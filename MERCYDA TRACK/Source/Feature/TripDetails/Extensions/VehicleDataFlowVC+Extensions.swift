//
//  VehicleDataFlowVC+Extensions.swift
//  MERCYDA TRACK
//
//  Created by test on 12/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import UIKit

extension VehicleFlowViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableView Data Source Protocol
       
       /// Return Number of Sections
       /// - Parameter tableView: UITTableView
       func numberOfSections(in tableView: UITableView) -> Int {
           return vehicleFlowViewModel.numberOfSections
       }
       
       /// Return Number of Rows in Sections
       /// - Parameters:
       ///   - tableView: UITableView
       ///   - section: Int Value
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return vehicleFlowViewModel.numberOfRowsInSection(section)
       }
       
       /// Return Cell for Row
       /// - Parameters:
       ///   - tableView: UITableView
       ///   - indexPath: IndexPath
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.VehicleDataFlowCell.rawValue , for: indexPath) as? VehicleDataFlowTableViewCell else {
               return UITableViewCell()
           }
        let dataPoints = self.vehicleFlowViewModel.dataPointForIndex(index: indexPath.row)
           cell.updateUI(value: dataPoints)
           return cell
       }
}
