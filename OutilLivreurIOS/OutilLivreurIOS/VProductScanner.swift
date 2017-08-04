//
//  VProductScanner.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 28/06/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit
import AVFoundation

class VProductScanner: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var _viewScan: UIView!
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    
    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedBarCodes
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = _viewScan.layer.bounds
            _viewScan.layer.addSublayer(videoPreviewLayer!)
            captureSession?.startRunning()
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                _viewScan.addSubview(qrCodeFrameView)
                _viewScan.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            print(error)
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
      /*  if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            //messageLabel.text = "No barcode/QR code is detected"
            return
        }
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if supportedBarCodes.contains(metadataObj.type) {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                
                if ( _controllerDelivery.getNameProduct(ref: metadataObj.stringValue) == "NoProduct") {
                    CreatePopUpWrongPackage(ref: metadataObj.stringValue)
                }
                else {
                    let refreshAlert = UIAlertController(title: "Référence détecté", message: "Article : " + _controllerDelivery.getNameProduct(ref: metadataObj.stringValue) + "\nRéf : " + metadataObj.stringValue, preferredStyle: UIAlertControllerStyle.alert)
                    refreshAlert.addAction(UIAlertAction(title: "Valider", style: .default, handler: { action in
                        self.ValidateTapped(ref: metadataObj.stringValue)}))
                    refreshAlert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
                    present(refreshAlert, animated: true, completion: nil)
                }
            }
        }*/
    }
    
    func ValidateTapped(ref : String)
    {
 
    }
    
    func CreatePopUpWrongPackage(ref: String) {
        let refreshAlert = UIAlertController(title: "Erreur", message: "La référence : " + ref + " ne fais pas partie des lost recu, Un message va étre envoyer a l'ERP", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Confirmer", style: .default, handler: nil))
        refreshAlert.addAction(UIAlertAction(title: "Annuer", style: .cancel, handler: nil))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    func CreatePopUpPackageCondition(ref: String) {
        let refreshAlert = UIAlertController(title: "Etat du colis ", message: "ref : 12345678", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Bon état", style: .default, handler: { action in self.ValidateTapped(ref : ref) }))
        refreshAlert.addAction(UIAlertAction(title: "Mauvais état", style: .default, handler: { action in self.DamagedPackage() }))
        refreshAlert.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil ))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func CreatePopUpPackageDeliver(ref: String) {
        let refreshAlert = UIAlertController(title: "Assigner un livreur ", message: "Veuiller assigner un livreur", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Livreur 1", style: .default, handler: nil ))
        refreshAlert.addAction(UIAlertAction(title: "Livreur 2", style: .default, handler: nil ))
        refreshAlert.addAction(UIAlertAction(title: "Livreur 3", style: .default, handler:  nil ))
        refreshAlert.addAction(UIAlertAction(title: "Consigne", style: .default, handler: nil ))
        refreshAlert.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: { action in self.CreatePopUpPackageCondition(ref: ref) }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func DamagedPackage() {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VProduct") as! VProduct
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
