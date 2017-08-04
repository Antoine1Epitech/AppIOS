//
//  VDelivery.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 05/07/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VDelivery: UIViewController, UITableViewDelegate, UITableViewDataSource,  UISearchBarDelegate, UISearchDisplayDelegate  {

    @IBOutlet weak var _table: UITableView!
    var _tabledata = [s_delivery]()
    var _mode = String()
    
    override func viewDidLoad() {
        if (_mode == "LIVRAISON") {
            _tabledata = _modelDelivery.getDeliveryForLivraison()
        }
        else {
            _tabledata = _modelDelivery._listDelivery
        }
        self.title = "Réception"
        super.viewDidLoad()
        self._table.delegate = self
        self._table.dataSource = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableDelivery: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self._tabledata.count)
    }
    
    func tableView(_ _table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("VCellDelivery", owner: self, options: nil)?.first as! VCellDelivery
        cell._lblRef.text = self._tabledata[indexPath.row]._ref
        let statut = self._tabledata[indexPath.row]._status
        /*if (statut == "TERMINE") {
            cell._lblStatus.textColor = UIColor.green
        }
        else if (statut == "EN COURS D'ACHEMINEMENT") {
            cell._lblStatus.textColor = UIColor.orange
        }
        else {
            cell._lblStatus.textColor = UIColor.red
        }*/
        cell._lblStatus.text = self._tabledata[indexPath.row]._status
        cell._nbProduct.text = String(self._tabledata[indexPath.row]._listPackage.count)
        cell._lblDate.text = self._tabledata[indexPath.row]._date
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ _table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        DispatchQueue.main.async{
            self._table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        if (_mode == "LIVRAISON")
        {
            let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            viewController._delivery = _tabledata[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else {
        let viewController = storyboard.instantiateViewController(withIdentifier: "VPackage") as! VPackage
        viewController._delivery = _tabledata[indexPath.row]
        viewController._mode = self._mode
        self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

}
