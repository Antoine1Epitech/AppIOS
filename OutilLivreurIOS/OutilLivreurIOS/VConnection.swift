//
//  VConnection.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 13/07/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VConnection: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var _txtPass: UITextField!
    @IBOutlet weak var _txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        _txtPass.delegate = self
        _txtName.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _txtPass.resignFirstResponder()
        _txtName.resignFirstResponder()
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
