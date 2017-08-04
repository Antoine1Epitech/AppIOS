//
//  VGarageMap.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 13/07/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Alamofire

class VGarageMap: UIViewController {


    var _data = [s_garage]()
    var _delivery = s_delivery()
    @IBOutlet weak var _mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = GMSMutablePath()
        _data = _modelDelivery.getGarageFromDeliver(refDelivery: _delivery._ref)
        let camera = GMSCameraPosition.camera(withLatitude: 48.853183, longitude: 2.369144, zoom: 13.0)
        self._mapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 48.8531827, longitude: 2.3691443000000163)
        path.add(marker.position)
        marker.title = "Ma position"
        marker.icon = GMSMarker.markerImage(with: UIColor.blue)
        marker.map = self._mapView
        
        for elem in _data {
            let address = elem._adress + ", " + elem._city + ", " + String(elem._zipCode) + ", France"
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) {
                placemarks, error in
                let placemark = placemarks?.first
                let lat = placemark?.location?.coordinate.latitude
                let lon = placemark?.location?.coordinate.longitude
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
                path.add(marker.position)
                marker.title = elem._nameOfGarage
                marker.snippet = elem._adress + "\nOrdre de passege : "
                marker.map = self._mapView
            }
        }
        let rectangle = GMSPolyline(path: path)
        rectangle.strokeWidth = 4
        rectangle.strokeColor = UIColor.red
        rectangle.map = self._mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
