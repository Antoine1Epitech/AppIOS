//
//  VProductDamaged.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 28/06/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit
import MobileCoreServices

class VProductDamaged: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate  {

    var _package = s_package()
    var _delivery = s_delivery()
    @IBOutlet weak var _img3: UIImageView!
    @IBOutlet weak var _img2: UIImageView!
    @IBOutlet weak var _img1: UIImageView!
    @IBOutlet weak var _textField: UITextField!
    @IBOutlet weak var _lblName: UILabel!
    @IBOutlet weak var _lblReference: UILabel!
    var idImg = 1
    var name = String()
    var ref = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._lblName.text = name
        self._lblReference.text = ref
        InitializeUIImageView()
        //self.title = ref
        _textField.delegate = self
    }
    
    func InitializeUIImageView() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped1(tapGestureRecognizer:)))
        _img1.isUserInteractionEnabled = true
        _img1.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
        _img2.isUserInteractionEnabled = true
        _img2.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped3(tapGestureRecognizer:)))
        _img3.isUserInteractionEnabled = true
        _img3.addGestureRecognizer(tapGestureRecognizer3)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    func imageTapped1(tapGestureRecognizer: UITapGestureRecognizer)
    {
       /* idImg = 1
        let camera = DSCameraHandler(delegate_: self)
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (alert : UIAlertAction!) in
            camera.getCameraOn(self, canEdit: true)
        }
        let sharePhoto = UIAlertAction(title: "Photo Library", style: .default) { (alert : UIAlertAction!) in
            camera.getPhotoLibraryOn(self, canEdit: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)*/
    }
    
    
    func imageTapped2(tapGestureRecognizer: UITapGestureRecognizer)
    {
       /* idImg = 2
        let camera = DSCameraHandler(delegate_: self)
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (alert : UIAlertAction!) in
            camera.getCameraOn(self, canEdit: true)
        }
        let sharePhoto = UIAlertAction(title: "Photo Library", style: .default) { (alert : UIAlertAction!) in
            camera.getPhotoLibraryOn(self, canEdit: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)*/
    }
    
    func imageTapped3(tapGestureRecognizer: UITapGestureRecognizer)
    {
        /*idImg = 3
        let camera = DSCameraHandler(delegate_: self)
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (alert : UIAlertAction!) in
            camera.getCameraOn(self, canEdit: true)
        }
        let sharePhoto = UIAlertAction(title: "Photo Library", style: .default) { (alert : UIAlertAction!) in
            camera.getPhotoLibraryOn(self, canEdit: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)*/
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        if (idImg == 1) {
            self._img1.contentMode = UIViewContentMode.scaleAspectFit
            _img1.image = image
        }
        else if (idImg == 2){
            self._img2.contentMode = UIViewContentMode.scaleAspectFit
            _img2.image = image
        }
        else if (idImg == 3){
            self._img3.contentMode = UIViewContentMode.scaleAspectFit
            _img3.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }

    /*@IBAction func closeDidTouched(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }*/
    
    @IBAction func BtnDidTouched(_ sender: Any) {
        _modelDelivery.setStateProduct(refDelivery: _delivery._ref, refPackage: _package._reference, refProduct: ref, state: DAMAGED)
         _ = navigationController?.popViewController(animated: true)
    }
}
