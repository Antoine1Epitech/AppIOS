//
//  VPakageList.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 28/06/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

var _saveMode = String()
var _saveDelivery = s_delivery()

class VPakageList: UIViewController, UITableViewDelegate, UITableViewDataSource,  UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var _btnValidate: UIButton!

    @IBOutlet weak var _table: UITableView!
    var _mode = String()
    var _delivery = s_delivery()
    var _listPackage = [s_package]()
    var resultsController = UITableView()
    var _searchBar = UISearchBar()
    var tmpNb = 0
        
    override func viewDidLoad() {
        _saveMode = _mode
        _saveDelivery = _delivery
        super.viewDidLoad()
        if (self._mode == "CONSIGNE") {
            self._listPackage = _modelDelivery.getPackageConsigne(refDelivery: _delivery._ref)
            self._btnValidate.isHidden = true
            /*var frame = _table.frame
             frame.size.width = self.view.frame.size.width
             frame.size.height = 615
             _table.frame = frame */
        }
        else if (self._mode == "LIVRAISON")
        {
            self._listPackage = _modelDelivery.getPackageFromDeliver(refDelivery: _delivery._ref)
            self._btnValidate.setTitle("Suivant",for: .normal)
        }
        else {
            self._listPackage = _modelDelivery.getPackageFromDelivery(ref: _delivery._ref)
        }
        self._table.delegate = self
        self._table.dataSource = self
        self._searchBar.searchBarStyle = UISearchBarStyle.default
        self._searchBar.placeholder = " Rechercher"
        self._searchBar.sizeToFit()
        self._searchBar.isTranslucent = false
        self._searchBar.delegate = self
        self._table.tableHeaderView = _searchBar
        let point = CGPoint(x: 0, y:(self._searchBar.frame.size.height))
        self._table.setContentOffset(point, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        if segue.identifier == "SegueDeliver"{
            if let nextViewController = segue.destination as? VPopUp{
                nextViewController._delivery = self._delivery
                nextViewController._package = self._listPackage[tmpNb]
            }
        }
    }
    
    @IBAction func ValidateDidTouched(_ sender: Any) {
        if (_mode == "LIVRAISON"){
            let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let viewController = storyboard.instantiateViewController(withIdentifier: "VRetour") as! VRetour
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        else {
            let tmp = _modelDelivery.getStatePackage(refDelivery: _delivery._ref)
            var str = String()
            
            if (tmp.nbChecked > 0) {
                str += String(tmp.nbChecked) + " lots en bon état.\n"        }
            if (tmp.nbDamaged > 0) {
                if (tmp.nbDamaged == 1) {
                    str += String(tmp.nbDamaged) + " lot en mauvais état.\n"
                }
                else {
                    str += String(tmp.nbDamaged) + " lots en mauvais état.\n"
                }
            }
            if (tmp.nbEmpty > 0) {
                if (tmp.nbEmpty == 1) {
                    str += String(tmp.nbEmpty) + " lot absent.\n"
                }
                else {
                    str += String(tmp.nbEmpty) + " lots absents.\n"
                }
            }
            if (tmp.nbFalse > 0) {
                if (tmp.nbFalse == 1) {
                    str += String(tmp.nbFalse) + " lot supplémentaire.\n"
                }
                else {
                    str += String(tmp.nbFalse) + " lots supplémentaires.\n"
                }
            }
            let refreshAlert = UIAlertController(title: "Confirmtion", message: "La récéption n°" + _delivery._ref + " est terminé.\nConfirmez vous la présence de :\n " + str, preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "Confirmer", style: .default, handler: { action in self.viewHome() }))
            refreshAlert.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil ))
            present(refreshAlert, animated: true, completion: nil)
            _modelDelivery.changeStatuDelivery(refDelivery : _delivery._ref)
        }
    }
    
    func viewHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"VHome") as! VHome
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func Reload(mode: String, delivery : s_delivery) {
        _mode = _saveMode
        _delivery = _saveDelivery
        if (self._mode == "CONSIGNE") {
            self._listPackage = _modelDelivery.getPackageConsigne(refDelivery: _delivery._ref)
        }
        else if (self._mode == "LIVRAISON")
        {
            self._listPackage = _modelDelivery.getPackageFromDeliver(refDelivery: _delivery._ref)
        }
        else {
            self._listPackage = _modelDelivery.getPackageFromDelivery(ref: _delivery._ref)
        }
        DispatchQueue.main.async{
            self._table.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Reload(mode: _mode, delivery: _delivery)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func CreatePopUpPackageCondition(sender: UIButton) {
        let cell = _table.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! CellPackage
        if (cell._isChecked == true) {
            cell._btnCheckedBox.setImage(#imageLiteral(resourceName: "checkEmpty"), for: .normal)
            cell._isChecked = false
            _modelDelivery.setPackageCheck(refDelivery: _delivery._ref, refPackage:  cell._lblRef.text!, checked: EMPTY)
        }
        else {
        let refreshAlert = UIAlertController(title: "Etat du colis ", message: "ref : " + cell._lblRef.text!, preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "Bon état", style: .default,  handler: { (action: UIAlertAction!) in
                cell._btnCheckedBox.setImage(#imageLiteral(resourceName: "checkChecked"), for: .normal)
               cell._isChecked = true
                _modelDelivery.setPackageCheck(refDelivery: self._delivery._ref, refPackage:  cell._lblRef.text!, checked: CHECKED)
            }))
            refreshAlert.addAction(UIAlertAction(title: "Mauvais état", style: .default, handler: { action in self.DamagedPackage(indexpath: IndexPath(row: sender.tag, section: 0), cell: cell) }))
        refreshAlert.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil ))
        present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    func CreatePopUpDeliver(sender: UIButton) {
        tmpNb = sender.tag
          performSegue(withIdentifier: "SegueDeliver", sender: nil)
    }
    
    func tableView(_ tableDelivery: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(_mode, self._listPackage.count)
        return (self._listPackage.count)
    }
    
    func tableView(_ _table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(_mode == "CONSIGNE"){
            let cell = Bundle.main.loadNibNamed("CellProductORetrait", owner: self, options: nil)?.first as! CellProductORetrait
            cell._lblArticle.text = self._listPackage[indexPath.row]._name
            cell._lblRef.text = self._listPackage[indexPath.row]._reference
            if (self._listPackage[indexPath.row]._box != -1) {
                cell._lblLocker.text = String(self._listPackage[indexPath.row]._box)
            }
            cell._btnInBox.tag = indexPath.row
            cell._btnInBox.addTarget(self, action: #selector(self.GoProduct), for: .touchUpInside)
            if (self._listPackage[indexPath.row]._delivered == true) {
                cell.backgroundColor = UIColor(rgb: 0xF1F3F3)
            }
            return cell
        }
        else {
            let cell = Bundle.main.loadNibNamed("CellPackage", owner: self, options: nil)?.first as! CellPackage
            cell._lblRef.text = self._listPackage[indexPath.row]._reference
            if (self._listPackage[indexPath.row]._checked == "FALSE") {
                cell._lblLot.text = "Lot supplémentaire : "
                cell._lblRef.frame.origin.x += 122
                cell._lblLot.sizeToFit()
                cell._isChecked = true
                cell._btnCheckedBox.setImage(#imageLiteral(resourceName: "checkFalse"), for: .normal)
                cell._btnCheckedBox.frame.origin.x += 31
            }
            else {
                cell._lblGarageName.text = self._listPackage[indexPath.row]._garage._nameOfGarage
                cell._lblDeliver.text = self._listPackage[indexPath.row]._deliver
                if (self._listPackage[indexPath.row]._checked == CHECKED) {
                    cell._btnCheckedBox.setImage(#imageLiteral(resourceName: "checkChecked"), for: .normal)
                    cell._isChecked = true
                }
                else if (self._listPackage[indexPath.row]._checked == DAMAGED) {
                    cell._btnCheckedBox.setImage(#imageLiteral(resourceName: "checkAlert"), for: .normal)
                    cell._isChecked = true
                }
                else if (self._listPackage[indexPath.row]._checked == EMPTY) {
                    cell._btnCheckedBox.setImage(#imageLiteral(resourceName: "checkEmpty"), for: .normal)
                    cell._isChecked = false
                }
                cell._btnDeliver.tag = indexPath.row
                cell._btnDeliver.addTarget(self, action: #selector(self.CreatePopUpDeliver), for: .touchUpInside)
                cell._btnCheckedBox.tag = indexPath.row
                cell._btnCheckedBox.addTarget(self, action: #selector(self.CreatePopUpPackageCondition), for: .touchUpInside)

                if (_mode == "LIVRAISON") {
                    cell._btnDeliver.isEnabled = false
                    cell._btnDeliver.isHidden = true
                    cell._btnCheckedBox.isEnabled = false
                    cell._btnCheckedBox.isHidden = true
                    cell.accessoryType = .disclosureIndicator
                    cell.selectionStyle = .default
                    if (self._listPackage[indexPath.row]._delivered == true) {
                        cell.backgroundColor = UIColor(rgb: 0xF1F3F3)
                    }
                }
            }
            return cell
        }
    }
    
    func tableView(_ _table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (_mode == "LIVRAISON") {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VProduct") as! VProduct
        viewController._delivery = _delivery
        viewController._mode = self._mode
        viewController._package = _listPackage[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
     func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
            let viewController = storyboard.instantiateViewController(withIdentifier: "VProduct") as! VProduct
            viewController._delivery = _delivery
            viewController._mode = self._mode
            viewController._package = _listPackage[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
    DispatchQueue.main.async{
            self._table.reloadData()
        }
    }
    
    func GoProduct(_ sender : UIButton) {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VProduct") as! VProduct
        viewController._delivery = _delivery
        viewController._package = _listPackage[sender.tag]
        viewController._mode = "CONSIGNE"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /*-------------------------------------------Functions PopUp  -------------------------------------------------*/
    
    func DamagedPackage(indexpath: IndexPath, cell: CellPackage) {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
         let viewController = storyboard.instantiateViewController(withIdentifier: "VProduct") as! VProduct
        viewController._delivery = _delivery
        viewController._package = _listPackage[indexpath.row]
        viewController._mode = DAMAGED
         self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
