
//
//  CellPackage.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 27/06/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class CellPackage: UITableViewCell {

    @IBOutlet weak var _btnDeliver: UIButton!
    @IBOutlet weak var _lblLot: UILabel!
    @IBOutlet weak var _lblRef: UILabel!
    @IBOutlet weak var _lblGarageName: UILabel!
    @IBOutlet weak var _lblDeliver: UILabel!
    @IBOutlet weak var _btnCheckedBox: UIButton!

    var _isChecked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
   
}
