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
                self.mapButton.isHidden = false
            case .failure(let error):
                statusBarMessage(.CustomError, error)
                self.mapButton.isHidden = true
            }
        }
    }
    
    @objc func cancelDatePicker(){
        pickerView.isHidden = true
        pickerBtn.titleLabel?.text = vehicleFlowViewModel?.titleDateForNavBtn(date: Date())
    }
    
    @IBAction func leftBarButtonAction(_ sender: Any) {
        leftBarBtnOutlet.isEnabled = false
        rightBarButton.isEnabled = false
        flagForDateTitle = false
        APItimer?.invalidate()
        APItimer = nil
        let day = Utility.stringToDate(dateString:curentDate)
        let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: day)
        curentDate = Utility.dataDatefornextDay(dateString: previousDay!)
        let previousDate = Utility.showDate(dateString: previousDay!)
        pickerBtn.titleLabel?.text = Utility.showDateForTitle(dateString: previousDay ?? NSDate() as Date)
        triggerApiCall(date: previousDate)
    }
    
    @IBAction func rightBarButtonAction(_ sender: Any) {
        leftBarBtnOutlet.isEnabled = false
        rightBarButton.isEnabled = false
        flagForDateTitle = false
        APItimer?.invalidate()
        APItimer = nil
        let day = Utility.stringToDate(dateString:curentDate)
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: day)
        // currentDate = generalUtil.dataDatefornextDay(dateString: nextDay!)
        // dayDateText = generalUtil.showDate(dateString: nextDay!
        curentDate = Utility.dataDatefornextDay(dateString: nextDay!)
        let nextDate = Utility.showDate(dateString: nextDay!)
        pickerBtn.titleLabel?.text = Utility.showDateForTitle(dateString: nextDay ?? NSDate() as Date)
        triggerApiCall(date: nextDate)        
    }
    
    func triggerApiCall(date: String) {
        MBProgressHUD.showAdded(to: view, animated: true)
               vehicleFlowViewModel?.getDetailsForSpecficDate(serialNo: serialNumber, date: date) {[weak self] result in
                   guard let self = self else {
                       return
                   }
                   MBProgressHUD.hide(for: self.view, animated: false)
                    self.leftBarBtnOutlet.isEnabled = true
                    self.rightBarButton.isEnabled = true
                   switch result {
                   case .success(_):
                       print("")
                       self.mapButton.isHidden = false
                   case .failure(let error):
                       statusBarMessage(.CustomError, error)
                       self.mapButton.isHidden = true
                   }
               }
    }
}
