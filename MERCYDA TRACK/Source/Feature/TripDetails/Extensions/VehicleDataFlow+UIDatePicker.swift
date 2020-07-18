//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import UIKit
import MBProgressHUD

extension VehicleFlowViewController {
    
    func showDatePicker(){
        //Formate Date
        pickerView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        pickerView.isHidden = true
        PickerCancelBtn.addTarget(self, action: #selector(cancelDatePicker), for: .touchUpInside)
        pickerDoneBtn.addTarget(self, action: #selector(donedatePicker), for: .touchUpInside)
        datePicker.datePickerMode = .date

    }
    
    @objc func donedatePicker(){
        pickerView.isHidden = true
        APItimer?.invalidate()
        APItimer = nil
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        pickerBtn.titleLabel?.text = formatter.string(from: datePicker.date)
        MBProgressHUD.showAdded(to: view, animated: true)
        vehicleFlowViewModel?.getDetailsForSpecficDate(serialNo: serialNumber, date: formatter.string(from: datePicker.date)) {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    @objc func cancelDatePicker(){
        pickerView.isHidden = true
    }
}