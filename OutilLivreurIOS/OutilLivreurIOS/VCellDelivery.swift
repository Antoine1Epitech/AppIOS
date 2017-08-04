//
//  VCellDelivery.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 05/07/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VCellDelivery: UITableViewCell {

    @IBOutlet weak var _lblDate: UILabel!
    @IBOutlet weak var _lblRef: UILabel!
    @IBOutlet weak var _lblStatus: UILabel!
    @IBOutlet weak var _nbProduct: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
