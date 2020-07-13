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
    
    var viewModel = MapVCViewModel()
    weak var delegateForMapPicker : MapPickerDelegate?
    lazy var mapView : GMSMapView? = GMSMapView()
    var carMarker:GMSMarker = GMSMarker.init(position: CLLocationCoordinate2D())
    var polyLineLocations:[CLLocationCoordinate2D] = []
    var animationPolyline = GMSPolyline()
    var path = GMSPath()
    var animationPath = GMSMutablePath()
    var i: UInt = 0
    var timer: Timer!
    
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
        viewModel.delegate = self
        viewModel.getDeviceData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
  
    func updateMap(_ locationsArray: [CLLocationCoordinate2D]) {
        self.focusMapToLocation(loctions: locationsArray, padding: 50.0, duration: 0.55, completionFunction: self.draw_polylines(loctions: self.polyLineLocations))
    }
    
    func updateParkingMarkers(Locations locationsArray: [CLLocationCoordinate2D], Devices deviceArray: [D]) {
        for (index,latlon) in locationsArray.enumerated() {
            let marker:GMSMarker = GMSMarker.init(position: latlon)
            marker.icon = deviceArray[index].vehicle_mode == "H" ? UIImage.init(named: "h_pin") : UIImage.init(named: "s_pin")
            marker.snippet = "Lat \(latlon.latitude) Lon \(latlon.longitude)"
            marker.title = deviceArray[index].vehicle_mode
            marker.userData = deviceArray[index]
            marker.map = mapView
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
                closeButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: -5),
                closeButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 5),
                closeButton.heightAnchor.constraint(equalToConstant: 35)
            ])
            closeButton.aspectRatio(1.0/1.0).isActive = true
            let lineGradient = GMSStrokeStyle.gradient(from: .systemBlue, to: .systemGreen)
            animationPolyline.spans = [GMSStyleSpan(style: lineGradient)]
        }
    }
    
    
    func focusMapToLocation(loctions: [CLLocationCoordinate2D], padding: CGFloat = 25, duration: CGFloat = 0.0005, completionFunction : Void? = nil) {
        var bounds = GMSCoordinateBounds()
        for location:CLLocationCoordinate2D in loctions {
            bounds = bounds.includingCoordinate(location)
        }
        CATransaction.begin()
        CATransaction.setValue(duration, forKey: kCATransactionAnimationDuration)
        CATransaction.setCompletionBlock {
            completionFunction
        }
        mapView?.animate(with: GMSCameraUpdate.fit(bounds, withPadding: padding))
        CATransaction.commit()
    }
    
    
    func setCarMarkers(position: CLLocationCoordinate2D) {
        carMarker.map = nil
        let marker:GMSMarker = GMSMarker.init(position: position)
        marker.icon =  UIImage.init(named: "car_pin")
        marker.snippet = "Lat \(position.latitude) Lon \(position.longitude)"
        marker.title = "User"
        carMarker = marker
        carMarker.map = mapView
        //marker.userData = position
    }
    
    
    func draw_polylines(loctions: [CLLocationCoordinate2D]) {
        let path = GMSMutablePath()
        for loc in loctions {
            path.addLatitude(loc.latitude, longitude:loc.longitude)
        }
        self.path = path
        let nonAnimatingPolyline = GMSPolyline()
        nonAnimatingPolyline.path = path
        nonAnimatingPolyline.strokeColor = UIColor(red: 05.0, green: 10.5, blue: 0, alpha: 0.1)
        nonAnimatingPolyline.strokeWidth = 5.0
        nonAnimatingPolyline.geodesic = true
        nonAnimatingPolyline.map = self.mapView
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(animatePolylinePath), userInfo: nil, repeats: true)
        
    }
    
    @objc func animatePolylinePath() {
        if (self.i < self.path.count()) {
            self.animationPath.add(self.path.coordinate(at: self.i))
            self.animationPolyline.path = self.animationPath
            self.animationPolyline.strokeColor = UIColor.cyan
            self.animationPolyline.strokeWidth = 6
            self.animationPolyline.geodesic = true
            self.animationPolyline.map = self.mapView
            self.setCarMarkers(position: self.path.coordinate(at: self.i))
            if self.animationPath.count() > 1 {
                self.focusMapToLocation(loctions: [self.path.coordinate(at: self.i), self.path.coordinate(at: self.i - 1)], padding: 100.0)
            }
            self.i += 1
        }
        else {
            self.i = 0
            self.setCarMarkers(position: self.path.coordinate(at: self.path.count() - 1))
            self.timer.invalidate()
            self.focusMapToLocation(loctions: self.polyLineLocations, padding: 50.0, duration: 1.80)
            print("last execution")
        }
    }
}
