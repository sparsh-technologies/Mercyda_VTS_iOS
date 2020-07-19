//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import UIKit
import MBProgressHUD

extension VehicleFlowViewController {
    
    func showDatePicker(){
        //Formate Date
        let currentDate = NSDate()  //get the current date
        pickerView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        pickerView.isHidden = true
        PickerCancelBtn.addTarget(self, action: #selector(cancelDatePicker), for: .touchUpInside)
        pickerDoneBtn.addTarget(self, action: #selector(donedatePicker), for: .touchUpInside)
        datePicker.datePickerMode = .date
        datePicker.maximumDate = currentDate as Date
    }
    
    @objc func donedatePicker(){
        pickerView.isHidden = true
        flagForDateTitle = false
        APItimer?.invalidate()
        APItimer = nil
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        pickerBtn.titleLabel?.text = vehicleFlowViewModel?.titleDateForNavBtn(date: datePicker.date)
        MBProgressHUD.showAdded(to: view, animated: true)
        vehicleFlowViewModel?.getDetailsForSpecficDate(serialNo: serialNumber, date: formatter.string(from: datePicker.date)) {[weak self] result in
            guard let self = self else {
                return
            }
            MBProgressHUD.hide(for: self.view, animated: false)
            switch result {
            case .success(_):
                print("")
            case .failure(let error):
                statusBarMessage(.CustomError, error)
            }
        }
    }
    
    @objc func cancelDatePicker(){
        pickerView.isHidden = true
    }
}
