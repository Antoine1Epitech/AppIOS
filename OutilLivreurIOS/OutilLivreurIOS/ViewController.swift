//
//  ViewController.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 11/07/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {



    @IBOutlet weak var _segmentedBar: UISegmentedControl!
    @IBOutlet weak var _viewSegmentedBar: UIView!
    var _delivery = s_delivery()

    lazy var _viewListGarage: VGarageList = {
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "VGarageList") as! VGarageList
        viewController._delivery = self._delivery
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var _viewGarageMap: VGarageMap = {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "VGarageMap") as! VGarageMap
        viewController._delivery = self._delivery
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "Parcours"
        self._viewListGarage.view.isHidden = !(_segmentedBar.selectedSegmentIndex == 0)
        self._viewGarageMap.view.isHidden = (_segmentedBar.selectedSegmentIndex == 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SelectionDidChanged(_ sender: Any) {
        self._viewListGarage.view.isHidden = !(_segmentedBar.selectedSegmentIndex == 0)
        self._viewGarageMap.view.isHidden = (_segmentedBar.selectedSegmentIndex == 0)
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
    
    

    @IBAction func ViewPackage(_ sender: Any) {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VPackage") as! VPackage
        viewController._delivery = _delivery
        viewController._mode = "LIVRAISON"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
