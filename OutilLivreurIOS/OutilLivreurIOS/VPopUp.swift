//
//  VPopUp.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 04/07/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VPopUp: UIViewController {

    var _delivery = s_delivery()
   var _package =  s_package()
    
    @IBOutlet weak var _btn1: UIButton!
    @IBOutlet weak var _btn2: UIButton!
    @IBOutlet weak var _btn3: UIButton!
    var _btnChoosed =  String()
    var _saveDeliver = String()
    
    override func viewDidLoad() {

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        super.viewDidLoad()
        if(_package._deliver == "Jean") {
            btn1DidTouched("")
            _btnChoosed = "Jean"
        }
        else if (_package._deliver == "Jacque") {
            btnDidTouched("")
            _btnChoosed = "Jacque"
        }
        else {
            btn3DidTouched("")
            _btnChoosed = "Consigne"
        }
        _saveDeliver = _btnChoosed
    }
    
    func setButton() {
        _btn1.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 0.0)
        _btn2.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 0.0)
        _btn3.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 0.0)
        _btn1.setImage(nil, for: .normal)
        _btn2.setImage(nil, for: .normal)
        _btn3.setImage(nil, for: .normal)
    }
    
    @IBAction func btnCancelDidTouched(_ sender: Any) {
        _modelDelivery.setDeliver(refDelivery: _delivery._ref, refPackage: _package._reference, deliver: _saveDeliver)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn1DidTouched(_ sender: Any) {
        setButton()
        _btn1.setImage(UIImage(named: "checkmark-3.png"), for: .normal)
        _btn1.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
         _modelDelivery.setDeliver(refDelivery: _delivery._ref, refPackage: _package._reference, deliver: "Jean")
    }
    @IBAction func btnDidTouched(_ sender: Any) {
        setButton()
        _btn2.setImage(UIImage(named: "checkmark-3.png"), for: .normal)
        _btn2.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
         _modelDelivery.setDeliver(refDelivery: _delivery._ref, refPackage: _package._reference, deliver: "Jacque")
    }

    @IBAction func btn3DidTouched(_ sender: Any) {
        setButton()
        _btn3.setImage(UIImage(named: "checkmark-3.png"), for: .normal)
        _btn3.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
         _modelDelivery.setDeliver(refDelivery: _delivery._ref, refPackage: _package._reference, deliver: "Consigne")
    }
    @IBAction func BtnContinueDidTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
