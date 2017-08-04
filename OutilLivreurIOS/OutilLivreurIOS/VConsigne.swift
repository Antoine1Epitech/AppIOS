//
//  VConsigne.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 13/07/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VConsigne: UIViewController {

    var _delivery = s_delivery()
    var _package = s_package()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func BtnValidateDidTouched(_ sender: Any) {
        _modelDelivery.setPackageCheck(refDelivery:  _delivery._ref, refPackage: _package._reference, checked: CHECKED)
        _ = navigationController?.popViewController(animated: true)
    }

}
