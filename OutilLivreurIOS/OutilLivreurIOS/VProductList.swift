//
//  VProductList.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 28/06/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VProductList: UIViewController, UITableViewDelegate, UITableViewDataSource,  UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var _btnValidate: UIButton!
    @IBOutlet weak var _table: UITableView!
    var _listProduct = [s_product]()
    var resultsController = UITableView()
    var _searchBar = UISearchBar()
    var _delivery = s_delivery()
    var _package = s_package()
    var _mode = String()
    var productState = 0
    var _stateBtn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._listProduct = _modelDelivery.getProductFromRef(refDelivery: _delivery._ref, refPackage: _package._reference)
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    

    func CreatePopUpPackageCondition(sender: UIButton) {
        let cell = _table.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! CellProduct
        if (_mode == "LIVRAISON") {
            let refreshAlert = UIAlertController(title: "Validation article ", message: cell._lblRef.text!, preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "Accepte l'article", style: .default, handler: {(action: UIAlertAction!) in
                cell._btnCheckBox.setImage(#imageLiteral(resourceName: "checkChecked"), for: .normal)
                cell._checked = true
                _modelDelivery.setStateProduct(refDelivery: self._delivery._ref, refPackage: self._package._reference, refProduct: cell._lblRef.text!, state: CHECKED)
            }))

            refreshAlert.addAction(UIAlertAction(title: "Refuse l'article", style: .default, handler:{(action: UIAlertAction!) in
                cell._btnCheckBox.setImage(#imageLiteral(resourceName: "checkFalse"), for: .normal)
                cell._checked = true
                _modelDelivery.setStateProduct(refDelivery: self._delivery._ref, refPackage: self._package._reference, refProduct: cell._lblRef.text!, state: FALSE)
            }))

            refreshAlert.addAction(UIAlertAction(title: "Article en mauvais etat", style: .default, handler: {(action: UIAlertAction!) in
                cell._btnCheckBox.setImage(#imageLiteral(resourceName: "checkAlert"), for: .normal)
                cell._checked = true
                _modelDelivery.setStateProduct(refDelivery: self._delivery._ref, refPackage: self._package._reference, refProduct: cell._lblRef.text!, state: DAMAGED)
            }))
            refreshAlert.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil ))
            present(refreshAlert, animated: true, completion: nil)
        }
        
        else if (_mode == "CONSIGNE") {
            let refreshAlert = UIAlertController(title: "Validation article ", message: cell._lblRef.text!, preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "Accepte l'article", style: .default, handler: {(action: UIAlertAction!) in
                cell._btnCheckBox.setImage(#imageLiteral(resourceName: "checkChecked"), for: .normal)
                cell._checked = true
                _modelDelivery.setStateProduct(refDelivery: self._delivery._ref, refPackage: self._package._reference, refProduct: cell._lblRef.text!, state: CHECKED)
            }))
            refreshAlert.addAction(UIAlertAction(title: "Article en mauvais etat", style: .default, handler: {(action: UIAlertAction!) in
                cell._btnCheckBox.setImage(#imageLiteral(resourceName: "checkAlert"), for: .normal)
                cell._checked = true
                _modelDelivery.setStateProduct(refDelivery: self._delivery._ref, refPackage: self._package._reference, refProduct: cell._lblRef.text!, state: DAMAGED)
            }))

            refreshAlert.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil ))
            present(refreshAlert, animated: true, completion: nil)        }
        
        else {
        let state =  _modelDelivery.getStateProduct(refDelivery: _delivery._ref, refPackage: _package._reference, refProduct: cell._lblRef.text!)
        if (state == "CHECKED") {
            cell._btnCheckBox.setImage(#imageLiteral(resourceName: "checkEmpty"), for: .normal)
            cell._checked = false
            productState -= 1
            _modelDelivery.setStateProduct(refDelivery: _delivery._ref, refPackage: _package._reference, refProduct: cell._lblRef.text!, state: EMPTY)
        }
        else {
        let refreshAlert = UIAlertController(title: "Etat du produit ", message: cell._lblRef.text!, preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "Bon état", style: .default, handler: {(action: UIAlertAction!) in
                cell._btnCheckBox.setImage(#imageLiteral(resourceName: "checkChecked"), for: .normal)
                cell._checked = true
                 self.productState += 1
                 _modelDelivery.setStateProduct(refDelivery: self._delivery._ref, refPackage: self._package._reference, refProduct: cell._lblRef.text!, state: CHECKED)
        }))

            refreshAlert.addAction(UIAlertAction(title: "Mauvais état", style: .default, handler: { action in self.DamagedProduct(name: cell._lblText.text!, ref: cell._lblRef.text!) }))
        refreshAlert.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil ))
        present(refreshAlert, animated: true, completion: nil)
        }
        }
    }
    
    /*-------------------------------------------Functions Table -------------------------------------------------*/
    
    func tableView(_ tableDelivery: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self._listProduct.count)
    }
    
    func tableView(_ _table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                  let cell = Bundle.main.loadNibNamed("CellProduct", owner: self, options: nil)?.first as! CellProduct
            cell._lblText.text = self._listProduct[indexPath.row]._name
            cell._lblRef.text = self._listProduct[indexPath.row]._reference
            let state = _modelDelivery.getStateProduct(refDelivery: _delivery._ref, refPackage: _package._reference, refProduct: cell._lblRef.text!)
            if (state == CHECKED) {
                cell._btnCheckBox.setImage(#imageLiteral(resourceName: "checkChecked"), for: .normal)
                cell._checked = true
                productState += 1
            }
            else if (state == EMPTY){
                cell._btnCheckBox.setImage(#imageLiteral(resourceName: "checkEmpty"), for: .normal)
                cell._checked = false
            }
            else if (state == DAMAGED){
                cell._btnCheckBox.setImage(#imageLiteral(resourceName: "checkAlert"), for: .normal)
                cell._checked = false
                productState += 1
            }
            cell._btnCheckBox.addTarget(self, action: #selector(self.CreatePopUpPackageCondition), for: .touchUpInside)
            cell._btnCheckBox.tag = indexPath.row
            return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        DispatchQueue.main.async{
            self._table.reloadData()
        }
    }
    
    func tableView(_ _table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59
    }
    
    func getStateBtn() -> Bool {
    return _stateBtn
    }
    func reload() {
        productState = 0
        self._listProduct = _modelDelivery.getProductFromRef(refDelivery: _delivery._ref, refPackage: _package._reference)
        DispatchQueue.main.async{
            self._table.reloadData()
        }
    }
    
    @IBAction func _btnValidateDidTouched(_ sender: Any) {
        if(_mode == "CONSIGNE"){
            let alertController = UIAlertController(title: "Information", message: "Veuillez indiquer dans quel casier vous souhaitez mettre le lot.", preferredStyle: .alert)
            alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
                textField.placeholder = "Numéro du casier"
            })
            let confirmAction = UIAlertAction(title: "Valider", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                _modelDelivery.setBoxAllArticle(refDelivery: self._delivery._ref, refPackage: self._package._reference, nbBox: Int((alertController.textFields?[0].text)!)!)
                self._listProduct = _modelDelivery.getProductFromRef(refDelivery: self._delivery._ref, refPackage: self._package._reference)
                DispatchQueue.main.async{
                    self._table.reloadData()
                }
                _modelDelivery.setPackageDelivered(refDelivery: self._delivery._ref, refPackage: self._package._reference)
                _ = self.navigationController?.popViewController(animated: true)
            })
            alertController.addAction(confirmAction)
            alertController.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil))
            present(alertController, animated: true, completion: { _ in })
        }
        else if (_mode == "LIVRAISON") {
            let alertController = UIAlertController(title: "Information", message: "Livraison du lot terminé.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                _modelDelivery.setPackageDelivered(refDelivery: self._delivery._ref, refPackage: self._package._reference)
            _ = self.navigationController?.popViewController(animated: true)
            }))
            present(alertController, animated: true, completion: { _ in })
        }
        else {
            print("nb article : ", _listProduct.count)
              print("nb article coché: ", productState)
        if (productState == _listProduct.count) {
            let str = "Le lot a correctement été enregistré en tant que colis endomagé."
            let refreshAlert = UIAlertController(title: "Information", message: str, preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "Continuer", style: .default, handler: {(action: UIAlertAction!) in
                _modelDelivery.setPackageCheck(refDelivery: self._delivery._ref, refPackage:  self._package._reference, checked: DAMAGED)
                self._stateBtn = true
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
        else {
            let str = "Veuillez indiquer les états de chaque article."
            let refreshAlert = UIAlertController(title: "Information", message: str, preferredStyle: UIAlertControllerStyle.alert)
            refreshAlert.addAction(UIAlertAction(title: "Continuer", style: .default, handler: nil))
            present(refreshAlert, animated: true, completion: nil)
        }
        }
    }
    
    func DamagedProduct(name: String, ref: String) {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
         let viewController = storyboard.instantiateViewController(withIdentifier: "VProductDamaged") as! VProductDamaged
        viewController._delivery = _delivery
        viewController._package = _package
        viewController.name = name
        viewController.ref = ref
         self.navigationController?.pushViewController(viewController, animated: true)
    }
}
