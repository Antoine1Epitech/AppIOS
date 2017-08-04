//
//  ViewController.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 27/06/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit

class VHome: UIViewController {
    
    @IBAction func ConsigneDidTouched(_ sender: Any) {
        
        performSegue(withIdentifier: "SegueConsignes", sender: nil)
    }
    
    @IBAction func btnLivraisonDidTouched(_ sender: Any) {
        performSegue(withIdentifier: "SegueLivraison", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueLivraison")
        {
            let nextScene = segue.destination as! VDelivery
            nextScene._mode = "LIVRAISON"
        }
        else if(segue.identifier == "SegueConsignes")
        {
            let nextScene = segue.destination as! VPackage
            nextScene._mode = "CONSIGNE"
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }

}

