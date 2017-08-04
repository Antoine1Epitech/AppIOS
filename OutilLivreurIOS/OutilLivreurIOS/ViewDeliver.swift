//
//  ViewDeliver.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 28/06/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class ViewDeliver: UIView {

    @IBOutlet weak var _btn1: UIButton!
    @IBOutlet weak var _btn2: UIButton!
    @IBOutlet weak var _btn3: UIButton!
    @IBOutlet weak var _btn4: UIButton!
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10.0
        var randomNum = Int(arc4random_uniform(2))
        randomNum += 1
        if (randomNum  == 1) {
            setButton()
            _btn1.setImage(UIImage(named: "checkmark.png"), for: .normal)
            _btn1.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            
        }
        else if (randomNum  == 2) {
            setButton()
            _btn2.setImage(UIImage(named: "checkmark.png"), for: .normal)
            _btn2.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
        else if (randomNum  == 3) {
            setButton()
            _btn3.setImage(UIImage(named: "checkmark.png"), for: .normal)
            _btn3.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
    }
    
    func setButton() {
        _btn1.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 22.0, bottom: 0.0, right: 0.0)
        _btn2.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 22.0, bottom: 0.0, right: 0.0)
        _btn3.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 22.0, bottom: 0.0, right: 0.0)
        _btn4.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 22.0, bottom: 0.0, right: 0.0)
        _btn1.setImage(nil, for: .normal)
        _btn2.setImage(nil, for: .normal)
        _btn3.setImage(nil, for: .normal)
        _btn4.setImage(nil, for: .normal)
    }
    
    @IBAction func _btn1Touched(_ sender: Any) {
        setButton()
        _btn1.setImage(UIImage(named: "checkmark.png"), for: .normal)
        _btn1.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    @IBAction func _btn2Touched(_ sender: Any) {
        setButton()
        _btn2.setImage(UIImage(named: "checkmark.png"), for: .normal)
        _btn2.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    @IBAction func _btn3Touched(_ sender: Any) {
        setButton()
        _btn3.setImage(UIImage(named: "checkmark.png"), for: .normal)
        _btn3.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    @IBAction func _btn4Touched(_ sender: Any) {
        setButton()
        _btn4.setImage(UIImage(named: "checkmark.png"), for: .normal)
        _btn4.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}
