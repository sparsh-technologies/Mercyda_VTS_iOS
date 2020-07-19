//
//  DashboardViewController.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 03/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit
import MBProgressHUD

class DashboardViewController: BaseViewController {
    
    /// Menu Button Name Labels
    @IBOutlet private weak var movingLbl: UILabel!
    @IBOutlet private weak var idleLbl: UILabel!
    @IBOutlet private weak var sleepLbl: UILabel!
    @IBOutlet private weak var onlineLbl: UILabel!
    @IBOutlet private weak var alertsLbl: UILabel!
    @IBOutlet private weak var dashboardLbl: UILabel!
    @IBOutlet private weak var reportsLbl: UILabel!
    @IBOutlet private weak var offlineLbl: UILabel!
    @IBOutlet private weak var bottomBannerLbl: UILabel!
    let vehicleList = [Vehicle]()
    
    /// Menu Button Notification Label
    @IBOutlet weak var offlineNotifiLbl: UILabel!
    @IBOutlet weak var sleepNotifiLbl: UILabel!
    @IBOutlet weak var idleNotifiLbl: UILabel!
    @IBOutlet weak var onlineNotfiLbl: UILabel!
    @IBOutlet weak var movingNotifLbl: UILabel!
    
    /// Menu Button Outlets
    @IBOutlet private weak var offlineBtnOutlet: UIButton!
    @IBOutlet private weak var reportsBtnOutlet: UIButton!
    @IBOutlet private weak var dashboardBtnOutlet: UIButton!
    @IBOutlet private weak var reportBtnOutlet: UIButton!
    @IBOutlet private weak var onlineBtnOutlet: UIButton!
    @IBOutlet private weak var sleepBtnOutlet: UIButton!
    @IBOutlet private weak var idleBtnOutlet: UIButton!
    @IBOutlet private weak var movingBtnOutlet: UIButton!
    @IBOutlet private weak var alldeviceBtnOutlet: UIButton!
    @IBOutlet  private weak var alertsBtnOutlet: UIButton!
    
    /// Dashboard ViewModel
    let dashboardViewModel = DashboardViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
            configureViewUI()
            self.getDashboardVehicleCount()
          
            
        
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = true
    }
    
    /// Configure UI with Label Names and Initial Values
    func configureViewUI() {
      //  self.navigationController?.navigationBar.isHidden = true
        movingLbl.text = DashboardLocalization.movingLbl.localized
        sleepLbl.text = DashboardLocalization.sleepLbl.localized
        alertsLbl.text = DashboardLocalization.alertsLbl.localized
        idleLbl.text = DashboardLocalization.idleLbl.localized
        reportsLbl.text = DashboardLocalization.reportsLbl.localized
        dashboardLbl.text = DashboardLocalization.dashboardLbl.localized
        offlineLbl.text = DashboardLocalization.offlineLbl.localized
        bottomBannerLbl.text = DashboardLocalization.bottomBanner.localized
        onlineLbl.text = DashboardLocalization.onlineLbl.localized
        
        sleepBtnOutlet.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        idleBtnOutlet.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        movingBtnOutlet.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        dashboardBtnOutlet.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        reportBtnOutlet.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        onlineBtnOutlet.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        offlineBtnOutlet.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        alertsBtnOutlet.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        alldeviceBtnOutlet.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        
    }
    
    /// Menu Button Action
    /// Tag 10 = Sleep
    /// Tag 11 = Idle
    /// Tag 12 = Sleep
    /// Tag 13 = Moving
    /// Tag 14 = Offline
    /// Tag 15 = Alerts
    /// Tag 16 = Dashboard
    /// Tag 17 = Reports
    /// Tag 18 = All Devices
    /// - Parameter button: UIButton Type
    @objc func menuButtonAction(button: UIButton) {
        switch button.tag {
        case 10,11,12,13,14,18:
            getVehiclesList(tag:button.tag)
        default:
            printLog("Nothing")
        }
        
    }
    
        
    @IBAction func logoutButtonAction(_ sender: Any) {
        UserLoginInfo.flushData()
        let story = UIStoryboard(name: StoryboardName.Login.rawValue, bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: StoryboardID.LOginViewControllerID.rawValue)as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func navigatetoVehicleListPage(vehiclelist:[Vehicle]){
        let story = UIStoryboard(name: StoryboardName.ListVehicle.rawValue, bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: StoryboardID.ListVehicle.rawValue)as! ListVehicleController
        vc.vehiclelist = vehiclelist
        self.navigationController?.pushViewController(vc, animated: true)
        }
        
    @IBAction func refreshButtonPressed(_ sender: Any) {
        getDashboardVehicleCount()
    }
    
    @IBAction func aboutUsButtonClicked(_ sender: Any) {
        
        let story = UIStoryboard(name: StoryboardName.AboutUs.rawValue, bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: StoryboardID.AboutusViewControllerId.rawValue)as! Aboutuscontroller
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getDashboardVehicleCount()  {
        MBProgressHUD.showAdded(to: view, animated: true)
        dashboardViewModel.getVehicleCount { [weak self] (result) in
            guard let this = self else {
                return
            }
            MBProgressHUD.hide(for: this.view, animated: false)
            printLog(result)
            switch result {
            case .success(let result):
                this.updateNotificationCOunt(vehicleCount: result)
                printLog("Vechile details Count \(result)")
            case .failure(let error):
                statusBarMessage(.CustomError, error)
                printLog(error)
            }
        }
       
    }
    
    

    func getVehiclesList(tag:Int) {
        MBProgressHUD.showAdded(to: view, animated: true)
        dashboardViewModel.getVehicleList { [weak self] (result) in
             guard let this = self else {
                           return
                       }
            MBProgressHUD.hide(for: this.view, animated: false)
            switch result{
            case .success(let result):
            MBProgressHUD.hide(for: this.view, animated: false)
            switch tag {
            case 18:
                this.navigatetoVehicleListPage(vehiclelist:result)
            case 10:
            this.dashboardViewModel.filterVehicleData(type:DashboardLocalization.movingVehicleKey.rawValue , data: result) { (filterdResult) in
            this.navigatetoVehicleListPage(vehiclelist:filterdResult)
            }
            case 12:
            this.dashboardViewModel.filterVehicleData(type:DashboardLocalization.sleepVehicleKey.rawValue, data:result) { (filterdResult ) in
            this.navigatetoVehicleListPage(vehiclelist:filterdResult)
            }
            case 11:
            this.dashboardViewModel.filterVehicleData(type:DashboardLocalization.idleVehicleKey.rawValue, data:result) { (filteredResult ) in
            this.navigatetoVehicleListPage(vehiclelist:filteredResult)
            }
            case 14:
            this.dashboardViewModel.filterOfflineData(data:result) { (filterdResult ) in
            this.navigatetoVehicleListPage(vehiclelist: filterdResult)
            }
            case 13:
            this.dashboardViewModel.filterOnlineData(data: result) { (filterdResult ) in
            this.navigatetoVehicleListPage(vehiclelist: filterdResult)
            }
            default:
                printLog("Nothing")
            }
            
            print("count:\(result.count)")
            case .failure(let error) :
            MBProgressHUD.hide(for: this.view, animated: false)
            printLog(error)
            }
        }
    }
    
    
    func updateNotificationCOunt(vehicleCount: getVehiclesCountResponse) {
        var count = Int(vehicleCount.running_count ?? 0)
        movingNotifLbl.text = String(count)
        count = Int(vehicleCount.idle_count ?? 0)
        sleepNotifiLbl.text = String(count)
        count = Int(vehicleCount.halt_count ?? 0)
        idleNotifiLbl.text = String(count)
        count = Int(vehicleCount.running_count ?? 0)
        onlineNotfiLbl.text = String(Int(vehicleCount.running_count ?? 0) + Int(vehicleCount.idle_count ?? 0) + Int(vehicleCount.running_count ?? 0))
        count = Int(vehicleCount.inactive_count ?? 0)
        offlineNotifiLbl.text = String(count)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
