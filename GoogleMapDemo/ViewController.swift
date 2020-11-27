//
//  ViewController.swift
//  GoogleMapDemo
//
//  Created by Jimmy on 2020/11/27.
//

import CoreLocation
import GoogleMaps
import UIKit
import SnapKit
class ViewController: UIViewController,CLLocationManagerDelegate {
    //MARK: - Properties
    let locationManager = CLLocationManager()
    var coordinateLabel : UILabel =
        {
            let label = UILabel()
            label.backgroundColor = .clear
            label.adjustsFontSizeToFitWidth = true
            label.textColor = .red
            label.numberOfLines = 2
            label.font = UIFont.systemFont(ofSize: 20)
            return label
        }()

    //MARK: - UI Elements
    var mapView:GMSMapView?
    
    //MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        setupCoordinateLabel()
    }
    override func viewDidAppear(_ animated: Bool) {
        setupMapView()
    }
    
    //MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        //        self.coordinate = location.coordinate
        setupMap(coordinate: location.coordinate)
        coordinateLabel.text = "經度：\(location.coordinate.longitude)\n緯度：\(location.coordinate.latitude)"
    }
    
    //MARK: - Configure map's marker
    func setupMap(coordinate: CLLocationCoordinate2D)
    {
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude:coordinate.longitude, zoom: 15)
        self.mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.title = "CoCoWork"
        marker.snippet = "Please hire me"
        marker.map = mapView
    }
    
    //MARK: - Setup UI
    func setupMapView()
    {
        if let mapView = self.mapView
        {
            
            view.addSubview(mapView)
            mapView.backgroundColor = .yellow
            mapView.snp.makeConstraints { (make) in
                make.left.bottom.right.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.8)
                
            }
            view.layoutIfNeeded()
        }
    }
    func setupCoordinateLabel()
    {
        self.view.addSubview(coordinateLabel)
        coordinateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.topMargin)
            make.height.equalToSuperview().multipliedBy(0.15)
            make.left.right.equalToSuperview()
        }
    }
}

