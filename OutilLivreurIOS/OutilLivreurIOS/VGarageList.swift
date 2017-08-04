//
//  VGarageList.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 13/07/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit
import CoreLocation


class VGarageList: UIViewController, UITableViewDelegate, UITableViewDataSource,  UISearchBarDelegate, UISearchDisplayDelegate  {
    
    var _delivery = s_delivery()
    var _tabledata = [s_garage]()
    var _myLocationLat = 48.8531827
    var _myLocationLon = 2.3691443000000163
    var _nextPointLat = 0
    @IBOutlet weak var _table: UITableView!
    
    override func viewDidLoad() {
        _tabledata = _modelDelivery.getGarageFromDeliver(refDelivery: _delivery._ref)
        super.viewDidLoad()
        self._table.delegate = self
        self._table.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableDelivery: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self._tabledata.count)
    }
    
    func tableView(_ _table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CustomCellGarage", owner: self, options: nil)?.first as! CustomCellGarage
        cell._garageName.text = _tabledata[indexPath.row]._nameOfGarage
        cell._adresse.text = _tabledata[indexPath.row]._adress
        cell._tel.text = _tabledata[indexPath.row]._phoneNumberGarage
        cell._nb.text = String(indexPath.row + 1)
        
        
        cell._btnJyVais.tag = indexPath.row
        cell._btnJySuis.tag = indexPath.row
        cell._btnUp.tag = indexPath.row
        cell._btnDown.tag = indexPath.row
        
        cell._btnUp.addTarget(self, action: #selector(UpDidTouched), for: .touchUpInside)
        cell._btnDown.addTarget(self, action: #selector(DownDidTouched), for: .touchUpInside)
        cell._btnJySuis.addTarget(self, action: #selector(JySuisDidTouched), for: .touchUpInside)
        cell._btnJyVais.addTarget(self, action: #selector(JyVaisDidTouched), for: .touchUpInside)
        
        return cell
    }
    
    func UpDidTouched(sender: UIButton){
        if (0 != sender.tag) {
            let element = _tabledata.remove(at: sender.tag)
            _tabledata.insert(element, at: sender.tag - 1)
            DispatchQueue.main.async{
                self._table.reloadData()
            }
        }
    }
    
    func DownDidTouched(sender: UIButton){
        if (_tabledata.count != sender.tag + 1) {
            let element = _tabledata.remove(at: sender.tag)
            _tabledata.insert(element, at: sender.tag + 1)
            DispatchQueue.main.async{
                self._table.reloadData()
            }
        }
    }
    
    func JySuisDidTouched(sender: UIButton) {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let viewController = storyboard.instantiateViewController(withIdentifier: "VService") as! VService
            viewController._delivery = _delivery
        viewController._nbPackage = _modelDelivery.getNbPackageForGarage(refDelivery: _delivery._ref, nameGarage: _tabledata[sender.tag]._nameOfGarage)
            viewController._mode = "LIVRAISON"
            self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func JyVaisDidTouched(sender: UIButton) {
        let alert = UIAlertController(title: "Selection", message: "Choisissez votre application de navigation", preferredStyle: .actionSheet
            
        )
        alert.addAction(UIAlertAction(title: "Google Maps", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Plan", style: .default, handler: { (action: UIAlertAction!) in self.PlanChoosen() }))
        alert.addAction(UIAlertAction(title: "Waze", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Annuler", style: .destructive , handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ _table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 196
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        DispatchQueue.main.async{
            self._table.reloadData()
        }
    }
    
    func GoogleMapsChoosen() {
        /*if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            UIApplication.sharedApplication().openURL(NSURL(string:
                "comgooglemaps://?saddr=&daddr=\(place.latitude),\(place.longitude)&directionsmode=driving")!)
        }
        else {
            NSLog("Can't use comgooglemaps://");
        }*/
    }
    
    func PlanChoosen() {
        let address = _tabledata[_nextPointLat]._adress + ", " + _tabledata[_nextPointLat]._city + ", " + String(_tabledata[_nextPointLat]._zipCode) + ", France"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let tmp1 = Float((placemark?.location?.coordinate.latitude)!)
            let tmp2 = Float((placemark?.location?.coordinate.longitude)!)
            UIApplication.shared.openURL(NSURL(string:
                "http://maps.apple.com/maps?saddr=\(String(self._myLocationLat)),\(String(self._myLocationLon))&daddr=\(String(tmp1)),\(String(tmp2))")! as URL)
        }
    }
}
