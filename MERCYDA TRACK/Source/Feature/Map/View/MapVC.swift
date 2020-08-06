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
    var viewModel : MapVCViewModel?
    weak var delegateForMapPicker : MapPickerDelegate?
    lazy var mapView : GMSMapView? = GMSMapView()
    var carMarker:GMSMarker = GMSMarker.init(position: CLLocationCoordinate2D())
    var polyLineLocations:[CLLocationCoordinate2D] = []
    var animationPolyline = GMSPolyline()
    var animationPolylineBase = GMSPolyline()
    var path = GMSPath()
    var animationPath = GMSMutablePath()
    var i: UInt = 0
    var timer: Timer!
    var mapFlag = 1
    var lat = 0.0
    var lon = 0.0
    
    
    private var dispatcher: Dispatcher?
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action:#selector(MapVC.dismissView) , for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "close_black"), for: .normal)
        return button
    }()
    
    deinit {
        self.timer = nil
        printLog("ViewController Released from memory : MapVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addMapView()
        viewModel?.delegate = self
        viewModel?.updateViewController()
        self.view.bringSubviewToFront(bottomFeaturesView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func changeMapViewBtn(_ sender: Any) {
        mapFlag += 1
        if mapFlag % 2 == 0 {
            mapView?.mapType = .satellite
        } else {
            mapView?.mapType = .normal
            
        }
    }
    
    @IBAction func routePlayBtn(_ sender: Any) {
    
    }
    
    @IBAction func currentLocationBtn(_ sender: Any) {
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 15)
        self.mapView?.camera = camera
        
    }
    
    @IBAction func mapFullScreenBtn(_ sender: Any) {
    }
    
    func updateMap(_ locationsArray: [CLLocationCoordinate2D]) {
        lat = locationsArray.first?.latitude ?? 0
        lon = locationsArray.last?.longitude ?? 0
        self.focusMapToLocation(loctions: locationsArray, padding: 50.0, duration: 0.55)
    }
    
    func updateParkingMarkers(Locations locationsArray: [CLLocationCoordinate2D], Devices deviceArray: [D]) {
        for (index,latlon) in locationsArray.enumerated() {
            let marker:GMSMarker = GMSMarker.init(position: latlon)
            marker.icon = deviceArray[index].vehicle_mode == "H" ? UIImage.init(named: "h_pin") : UIImage.init(named: "s_pin")
            marker.snippet = "Lat \(latlon.latitude) Lon \(latlon.longitude)"
            marker.title = deviceArray[index].vehicle_mode
            marker.userData = deviceArray[index]
            marker.appearAnimation = .pop
            marker.tracksInfoWindowChanges = true
            UIView.animate(withDuration: 2.1, animations: {
                marker.map = self.mapView
            })
        }
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func addMapView() {
        mapView?.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        if let map = mapView {
            map.delegate = self
            self.view.addSubview(map)
            NSLayoutConstraint.activate([
                map.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                map.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                map.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
                map.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
            ])
            self.view.addSubview(closeButton)
            NSLayoutConstraint.activate([
                closeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
                closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
                closeButton.heightAnchor.constraint(equalToConstant: 35)
            ])
            closeButton.aspectRatio(1.0/1.0).isActive = true
            let lineGradient = GMSStrokeStyle.gradient(from: .systemBlue, to: .systemGreen)
            animationPolyline.spans = [GMSStyleSpan(style: lineGradient)]
        }
    }
    
    
    func focusMapToLocation(loctions: [CLLocationCoordinate2D], padding: CGFloat = 25, duration: CGFloat = 0.0005, completionFunction : Void? = nil, completionFunction2 : Void? = nil) {
        var bounds = GMSCoordinateBounds()
        for location:CLLocationCoordinate2D in loctions {
            bounds = bounds.includingCoordinate(location)
        }
        CATransaction.begin()
        CATransaction.setValue(duration, forKey: kCATransactionAnimationDuration)
        CATransaction.setCompletionBlock {
            self.draw_polylines(loctions: self.polyLineLocations)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.viewModel?.updateParkingMarkers()
            }
        }
        mapView?.animate(with: GMSCameraUpdate.fit(bounds, withPadding: padding))
        CATransaction.commit()
    }
    
    
    func setCarMarkers(position1: CLLocationCoordinate2D, position2: CLLocationCoordinate2D) {
        carMarker.map = nil
        let marker:GMSMarker = GMSMarker.init(position: position1)
        marker.icon =  UIImage.init(named: "car_pin")
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
        let nonAnimatingPolyline = GMSPolyline()
        nonAnimatingPolyline.path = path
        nonAnimatingPolyline.strokeColor = UIColor(red: 05.0, green: 10.5, blue: 0, alpha: 0.5)
        nonAnimatingPolyline.strokeWidth = 5.0
        nonAnimatingPolyline.geodesic = true
        nonAnimatingPolyline.map = self.mapView
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(animatePolylinePath), userInfo: nil, repeats: true)
        //        for (index,coordinates) in viewModel.arrForHaltAndStopLocations.enumerated() {
        //            getLocationDetails(locationCoordinates: coordinates, count: index)
        //
        //        }
    }
    
    
    func getLocationDetails(locationCoordinates: Latlon, count: Int) {
        defer {
            self.dispatcher?.getLocationDetails(locationCoordinates: locationCoordinates) { [unowned self] (cityAddress) in
                printLog("Execute DispatchWork \(count)")
                printLog("\(cityAddress) \n")
                if count == self.viewModel?.arrForHaltAndStopLocations.count ?? 0 - 1 {
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
        if (self.i < self.path.count()) {
            self.animationPath.add(self.path.coordinate(at: self.i))
            
            self.animationPolylineBase.path = self.animationPath
            self.animationPolylineBase.strokeColor = UIColor.black
            self.animationPolylineBase.strokeWidth = 7
            self.animationPolylineBase.geodesic = true
            self.animationPolylineBase.map = self.mapView
            
            self.animationPolyline.path = self.animationPath
            self.animationPolyline.strokeWidth = 4
            self.animationPolyline.geodesic = true
            self.animationPolyline.map = self.mapView
            
            
            
            self.setCarMarkers(position1: self.path.coordinate(at: self.i), position2: self.path.coordinate(at: self.i + 1))
            //            if self.animationPath.count() > 1 {
            //                self.focusMapToLocation(loctions: [self.path.coordinate(at: self.i), self.path.coordinate(at: self.i - 1)], padding: 100.0)
            //            }
            self.i += 1
        }
        else {
            self.i = 0
            // self.setCarMarkers(position: self.path.coordinate(at: self.path.count() - 1))
            self.setCarMarkers(position1: self.path.coordinate(at: self.path.count() - 1), position2: self.path.coordinate(at: self.path.count() - 1))
            self.timer.invalidate()
            // self.focusMapToLocation(loctions: self.polyLineLocations, padding: 50.0, duration: 1.80)
            print("last execution")
        }
    }
}
