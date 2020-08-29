//
//  MapVC.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 06/07/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation
import GoogleMaps


protocol MapPickerDelegate: class {
    func didSelectMarkerFromMap(selectedD: D)
}

class MapVC: UIViewController {
    
    @IBOutlet private weak var bottomFeaturesView: UIView!
    @IBOutlet weak var topVehicleView: UIView!
    @IBOutlet weak var speedView: UIView!
    @IBOutlet weak var innerSpeedView: UIView!
    
    @IBOutlet private weak var vehicleContainerView: UIView!
    @IBOutlet weak var vehicleImageview: UIImageView!
    @IBOutlet weak var vehicleNumber: UILabel!
    @IBOutlet weak var signalImageView: UIImageView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var ignitionImageView: UIImageView!
    @IBOutlet weak var isActiveImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var lastUpdatedDateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    var viewModel : MapVCViewModel?
    weak var delegateForMapPicker : MapPickerDelegate?
    lazy var mapView : GMSMapView? = GMSMapView()
    var carMarker:GMSMarker = GMSMarker.init(position: CLLocationCoordinate2D())
    var polyLineLocations:[CLLocationCoordinate2D] = []
    var animationPolyline = GMSPolyline()
    var animationPolylineBase = GMSPolyline()
    var path : GMSMutablePath?
    var animationPath = GMSMutablePath()
    var i: UInt = 0
    var dispTime : DispatchTime = DispatchTime(uptimeNanoseconds: UInt64(0.00))
    var vehicleObject:Vehicle?
    let lineGradient = GMSStrokeStyle.gradient(from: .systemBlue, to: .systemBlue)
    var mapViewTopConstraint : NSLayoutConstraint!
    var vehicleType = "car_pin"
    //var lastParkingLocation : CLLocationCoordinate2D?
    
    private var dispatcher: Dispatcher?
    
    var timer: Timer!
    var mapFlag = 1
    var isNavFlag = 0
    
    deinit {
        viewModel?.APItimer?.invalidate()
        viewModel = nil
        printLog("ViewController Released from memory : MapVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addMapView()
        viewModel?.delegate = self
        viewModel?.updateViewController()
        setuiDatas()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    func setUpPolylineConfiguration() {
        self.animationPolylineBase.strokeColor = UIColor.black
        self.animationPolylineBase.strokeWidth = 7
        self.animationPolylineBase.geodesic = true
        self.animationPolyline.strokeWidth = 4
        self.animationPolyline.geodesic = true
        animationPolyline.spans = [GMSStyleSpan(style: lineGradient)]
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        vehicleContainerView.roundCorners(.allCorners, radius: 15)
        innerSpeedView.roundCorners([.bottomLeft, .bottomRight], radius: 10)
        Utility.setShadow(view: self.speedView, color: .lightGray, cornerRadius: 10)
    }
    
    @IBAction func changeMapViewBtn(_ sender: Any) {
        mapFlag += 1
        mapView?.mapType = mapFlag % 2 == 0 ? .satellite : .normal
    }
    
    @IBAction func routePlayBtn(_ sender: Any) {
        mapView?.clear()
        self.animationPolyline = GMSPolyline()
        self.animationPolylineBase = GMSPolyline()
        self.animationPath = GMSMutablePath()
        setUpPolylineConfiguration()
        self.viewModel?.stopUpdateLocations()
        self.updateMap(self.polyLineLocations)
    }
    
    @IBAction func currentLocationBtn(_ sender: Any) {
        if let location = self.polyLineLocations.last {
            let camera = GMSCameraPosition.camera(withTarget: location, zoom: 55)
            CATransaction.begin()
            CATransaction.setAnimationDuration(2.00)
            self.mapView?.animate(with: GMSCameraUpdate.setCamera(camera))
            CATransaction.commit()
        }
    }
    
    @IBAction func mapFullScreenBtn(_ sender: Any) {
        isNavFlag += 1
        fullScreenMap(isNavFlag % 2 == 0)
    }
    
    func setuiDatas(){
        self.vehicleNumber.text = vehicleObject?.vehicle_registration
        self.addressLabel.text = vehicleObject?.address2
        if let speed =  vehicleObject?.last_updated_data?.speed{
            if speed > 0{
                speedLabel.text = "\(speed)"
                
            }
        }
        if let signalStrength = vehicleObject?.last_updated_data?.gsm_signal_strength{
            setSignalStrength(signalStrength: signalStrength)
            
        }
        
        if let activeStatus = vehicleObject?.last_updated_data?.valid_status{
            if activeStatus{
                isActiveImageView.image = UIImage.init(named:"dishActive")
            }
            else{
                isActiveImageView.image = UIImage.init(named:"dishInactive")
            }
        }
        
        if let igngitionStatus = vehicleObject?.last_updated_data?.ignition{
            setIgnition(status:igngitionStatus)
        }
        
        getVehicleType(type: vehicleObject?.vehicle_type ?? "")
        //        if let vehicleMode = vehicleObject?.last_updated_data?.vehicle_mode {
        //            setVehicleMode(mode:vehicleMode)
        //        }
        
        
        if type == "Moving"{
            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.green , secondColor:Utility.hexStringToUIColor("#1AA61D"))
        }
        else if type == "Sleep"{
            self.vehicleContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
        }
        else if type == "Idle"{
            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.blue, secondColor:Utility.hexStringToUIColor("#4252D9"))
        }
        else if type == "Dashboard"{
            if let vehicleMode = vehicleObject?.last_updated_data?.vehicle_mode {
                setVehicleMode(mode:vehicleMode)
            }
        }
        else if type == "Offline"{
            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.red, secondColor:UIColor.red)
        }
    }
    
    func setSignalStrength(signalStrength:Int){
        if signalStrength > 80 {
            signalImageView.image = UIImage.init(named: "fullrange")
        }
        else if (signalStrength >= 65 && signalStrength <= 79) {
            signalImageView.image = UIImage.init(named: "range75")
        }
        else if  (signalStrength >= 30 && signalStrength <= 64) {
            signalImageView.image = UIImage.init(named: "range50")
        }
        else if  (signalStrength >= 5 && signalStrength <= 29) {
            signalImageView.image = UIImage.init(named: "range25")
        }
        else{
            signalImageView.image = UIImage.init(named: "rangeInactive")
        }
    }
    
    func setIgnition(status:String){
        switch status {
        case IgnitionType.ON.rawValue:
            ignitionImageView.image = UIImage.init(named:"ignition")
        case IgnitionType.OFF.rawValue:
            ignitionImageView.image = UIImage.init(named:"ignitionoff")
        default:
            ignitionImageView.image = UIImage.init(named:"ignition")
        }
    }
    
    func setVehicleMode(mode:String){
        switch mode{
        case VehicleMode.Moving.rawValue:
            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.green , secondColor:Utility.hexStringToUIColor("#1AA61D"))
        case VehicleMode.Sleep.rawValue:
            self.vehicleContainerView.addGradientBackground(firstColor:Utility.hexStringToUIColor("#EFD61C"), secondColor: UIColor.orange)
        case VehicleMode.Idle.rawValue:
            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.blue, secondColor:Utility.hexStringToUIColor("#4252D9"))
        default:
            self.vehicleContainerView.addGradientBackground(firstColor:UIColor.green, secondColor: UIColor.black)
        }
    }
    func getVehicleType(type:String){
        switch type{
        case VehicleModel.Lorry.rawValue:
            self.vehicleImageview.image = UIImage.init(named:"Lorry")
            vehicleType = "ic_lorry"
        case VehicleModel.MiniTruck.rawValue:
            self.vehicleImageview.image = UIImage.init(named: "minilorry")
            vehicleType = "ic_mini_truck"
        case VehicleModel.Car.rawValue:
            self.vehicleImageview.image = UIImage.init(named: "car")
            vehicleType = "ic_car"
        default:
            self.vehicleImageview.image = UIImage.init(named:"Lorry")
            vehicleType = "ic_lorry"
        }
    }
    
    
    
    func updateMap(_ locationsArray: [CLLocationCoordinate2D]) {
        self.focusMapToLocation(loctions: locationsArray,duration: 2.0, completionFunction: {
            self.draw_polylines(loctions: self.polyLineLocations)
        }) {
            // Removed updating markers for now later if needed uncomment the line
           // self.viewModel?.updateParkingMarkers()
        }
    }
    
    func updateParkingMarkers(Locations locationsArray: [CLLocationCoordinate2D], Devices deviceArray: [TripDetailsModel]) {
        var yAnchor: CGFloat = -500
        
        for (index,latlon) in locationsArray.enumerated() {
            let marker:GMSMarker = GMSMarker.init(position: latlon)
            var iconImage =  UIImage.init(named: "h_pin")
            if index == locationsArray.count - 1 {
                iconImage = UIImage.init(named: "startPin")
            }
            marker.snippet = "Lat \(latlon.latitude) Lon \(latlon.longitude)"
           // marker.title = deviceArray[index].vehicle_mode
            marker.userData = deviceArray[index]
            let iconView = CustomMarkerView.init(image: iconImage ?? UIImage())
            marker.iconView = iconView
            iconView.transform = CGAffineTransform.init(translationX: 0, y: yAnchor )
            yAnchor -= 100
            marker.map = self.mapView
            
            CATransaction.begin()
            UIView.animate(withDuration: 0.50, delay: 0.0, options: .curveEaseOut, animations: {
                iconView.transform = CGAffineTransform.identity
            })
            CATransaction.commit()
        }
        CATransaction.flush()
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func addMapView() {
        mapView?.translatesAutoresizingMaskIntoConstraints = false
        if let map = mapView {
            mapViewTopConstraint = map.topAnchor.constraint(equalTo: self.topVehicleView.bottomAnchor, constant: 0)
            map.delegate = self
            self.view.addSubview(map)
            NSLayoutConstraint.activate([
                map.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                map.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                mapViewTopConstraint,
                map.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
            ])
        }
        setUpPolylineConfiguration()
        DispatchQueue.main.async {
            self.view.bringSubviewToFront(self.bottomFeaturesView)
            self.view.bringSubviewToFront(self.topVehicleView)
            self.view.bringSubviewToFront(self.speedView)
            self.view.layoutIfNeeded()
        }
    }
    
    func fullScreenMap(_ show: Bool) {
        DispatchQueue.main.async {
            self.mapViewTopConstraint.isActive = false
            self.mapViewTopConstraint = self.mapView?.topAnchor.constraint(equalTo: show ? self.topVehicleView.bottomAnchor : self.view.topAnchor, constant: 0)
            self.mapViewTopConstraint.isActive = true
            self.topVehicleView.isHidden = !show
            self.speedView.isHidden = !show
            UIView.animate(withDuration: show ? 0.0 : 0.5, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 20.3, options: [.curveEaseInOut], animations: {
                self.navigationController?.setNavigationBarHidden(!show, animated: false)
            })
        }
    }
    
    func focusMapToLocation(loctions: [CLLocationCoordinate2D], padding: CGFloat = 50, duration: CGFloat = 0.0005, completionFunction : @escaping () -> Void, completionFunction2 : @escaping () -> Void) {
        var bounds = GMSCoordinateBounds()
        for location:CLLocationCoordinate2D in loctions {
            bounds = bounds.includingCoordinate(location)
        }
        CATransaction.begin()
        CATransaction.setValue(duration, forKey: kCATransactionAnimationDuration)
        CATransaction.setCompletionBlock {
            completionFunction()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                completionFunction2()
            }
        }
        mapView?.animate(with: GMSCameraUpdate.fit(bounds, withPadding: padding))
        CATransaction.commit()
        CATransaction.flush()
    }
    
    
    
    func setCarMarkers(position1: CLLocationCoordinate2D, position2: CLLocationCoordinate2D) {
        carMarker.map = nil
        let marker:GMSMarker = GMSMarker.init(position: position1)
        marker.icon =  UIImage.init(named: vehicleType)
        marker.position = position1
        marker.groundAnchor = CGPoint.init(x: CGFloat(0.5), y: CGFloat(0.5))
        marker.rotation = CLLocationDegrees.init(exactly: getHeadingForDirection(fromCoordinate: position1, toCoordinate: position2))!
        marker.snippet = "Lat \(position1.latitude) Lon \(position1.longitude)"
        marker.title = "User"
        
        carMarker = marker
        carMarker.tracksInfoWindowChanges = true
        carMarker.map = mapView
        //marker.userData = position
    }
    
    
    func getHeadingForDirection(fromCoordinate fromLoc: CLLocationCoordinate2D, toCoordinate toLoc: CLLocationCoordinate2D) -> Float {
        let fLat: Float = Float((fromLoc.latitude).degreesToRadians)
        let fLng: Float = Float((fromLoc.longitude).degreesToRadians)
        let tLat: Float = Float((toLoc.latitude).degreesToRadians)
        let tLng: Float = Float((toLoc.longitude).degreesToRadians)
        let degree: Float = (atan2(sin(tLng - fLng) * cos(tLat), cos(fLat) * sin(tLat) - sin(fLat) * cos(tLat) * cos(tLng - fLng))).radiansToDegrees
        if degree >= 0 {
            return degree
        }
        else {
            return 360 + degree
        }
    }
    
    
    
    
    func draw_polylines(loctions: [CLLocationCoordinate2D]) {
        let path = GMSMutablePath()
        for loc in loctions {
            path.addLatitude(loc.latitude, longitude:loc.longitude)
        }
        self.path = path
        //        let nonAnimatingPolyline = GMSPolyline()
        //        nonAnimatingPolyline.path = path
        //        nonAnimatingPolyline.strokeColor = UIColor(red: 05.0, green: 10.5, blue: 0, alpha: 0.5)
        //        nonAnimatingPolyline.strokeWidth = 5.0
        //        nonAnimatingPolyline.geodesic = true
        //        nonAnimatingPolyline.map = self.mapView
        self.dispTime = DispatchTime.now()
        CATransaction.flush()
        for _ in 0..<self.polyLineLocations.count + 1 {
            DispatchQueue.main.asyncAfter(deadline: dispTime, execute: {
                self.animatePolylinePath()
            })
            self.dispTime = self.dispTime + 0.015
        }
        
    }
    
    
    func getLocationDetails(locationCoordinates: Latlon, count: Int) {
        defer {
            self.dispatcher?.getLocationDetails(locationCoordinates: locationCoordinates) { [unowned self] (cityAddress) in
                printLog("Execute DispatchWork \(count)")
                printLog("\(cityAddress) \n")
                if count == self.viewModel?.arrForHaltAndStopLocations?.count ?? 0 - 1 {
                    self.dispatcher = nil
                }
            }
        }
        guard self.dispatcher != nil else {
            self.dispatcher = Dispatcher()
            return
        }
    }
    
    @objc func animatePolylinePath() {
        if let gmsPath = self.path {
            CATransaction.begin()
            if (self.i < gmsPath.count()) {
                self.animationPath.add(gmsPath.coordinate(at: self.i))
                self.animationPolylineBase.path = self.animationPath
                self.animationPolylineBase.map = self.mapView
                
                self.animationPolyline.path = self.animationPath
                self.animationPolyline.map = self.mapView
                self.setCarMarkers(position1: gmsPath.coordinate(at: self.i), position2: gmsPath.coordinate(at: self.i + 1))
                self.i += 1
            } else {
                if gmsPath.count() >= self.i && gmsPath.count() > 0 {
                    self.setCarMarkers(position1: gmsPath.coordinate(at: self.i - 1), position2: gmsPath.coordinate(at: self.i - 1))
                }
                self.i = 0
                self.dispTime = DispatchTime(uptimeNanoseconds: UInt64(0.00))
                self.viewModel?.startUpdateLocations()
                print("last execution")
            }
            CATransaction.commit()
        }
    }
}
