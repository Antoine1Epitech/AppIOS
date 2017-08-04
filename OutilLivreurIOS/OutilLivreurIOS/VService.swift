//
//  VService.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 31/07/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VService: UIViewController {

    var _delivery = s_delivery()
    var _nbPackage = [s_package]()
    var _mode = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
    }
    

    @IBAction func BtnDidTouched(_ sender: Any) {
        
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        if (_nbPackage.count > 1) {
            let viewController = storyboard.instantiateViewController(withIdentifier: "VPackage") as! VPackage
            viewController._delivery = _delivery
            viewController._mode = "LIVRAISON"
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else {
            let viewController = storyboard.instantiateViewController(withIdentifier: "VProduct") as! VProduct
            viewController._delivery = _delivery
            viewController._package = _nbPackage[0]
            viewController._mode = "LIVRAISON"
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }

}
