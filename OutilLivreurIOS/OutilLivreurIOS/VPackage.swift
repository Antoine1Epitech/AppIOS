//
//  VPackage.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 28/06/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VPackage: UIViewController {

    @IBOutlet weak var _btnAdd: UIBarButtonItem!
    @IBOutlet weak var _viewSegmentedBar: UIView!
    @IBOutlet weak var _segmentedBar: UISegmentedControl!
    var _delivery = s_delivery()
    var _mode = String()
    
    lazy var _viewListProduct: VPakageList = {
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "VPakageList") as! VPakageList
        
        if (self._mode == "CONSIGNE") {
            self._btnAdd.isEnabled = false
            self._btnAdd.tintColor = UIColor.clear
            var tmp = _modelDelivery.getDeliveryForLivraison()
            if (tmp.count != 0){
                viewController._delivery = tmp[0]
                viewController._mode = self._mode
                self.addViewControllerAsChildViewController(childViewController: viewController)
            }
        }
        else {
            viewController._delivery = self._delivery
            viewController._mode = self._mode
        }
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var _viewScannerProduct: VPackageScanner = {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "VPackageScanner") as! VPackageScanner
        viewController._delivery = self._delivery
        viewController._mode = self._mode
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        self._viewListProduct.view.isHidden = !(_segmentedBar.selectedSegmentIndex == 0)
        self._viewListProduct.Reload(mode: _mode, delivery: _delivery)
        self._viewScannerProduct.view.isHidden = (_segmentedBar.selectedSegmentIndex == 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "Lots"
        if (_mode == "LIVRAISON") {
            self.title = "Livraison"
        }
        self._viewListProduct.view.isHidden = !(_segmentedBar.selectedSegmentIndex == 0)
        self._viewScannerProduct.view.isHidden = (_segmentedBar.selectedSegmentIndex == 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SelectionDidChanged2(_ sender: Any) {
        self._viewListProduct.view.isHidden = !(_segmentedBar.selectedSegmentIndex == 0)
        print("ref:", _delivery._ref)
        self._viewListProduct.Reload(mode: _mode, delivery: _delivery)
        self._viewScannerProduct.view.isHidden = (_segmentedBar.selectedSegmentIndex == 0)
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        view.insertSubview(childViewController.view, belowSubview: self._viewSegmentedBar)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }

    @IBOutlet weak var AddRef: UIBarButtonItem!
    
    @IBAction func AddRefDidTouched(_ sender: Any) {
        let alertController = UIAlertController(title: "Colis supplémentaire", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Veuillez indiquer la raférence du colis supplémentaire"
        })
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            _modelDelivery.addPackage(refDelivery: self._delivery._ref, ref: (alertController.textFields?[0].text)!)
             self._viewListProduct.Reload(mode: self._mode, delivery: self._delivery)
        })
        alertController.addAction(confirmAction)
        alertController.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil))
        present(alertController, animated: true, completion: { _ in })
        
    }

}
