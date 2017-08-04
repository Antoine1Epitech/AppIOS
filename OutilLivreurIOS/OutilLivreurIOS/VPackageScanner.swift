//
//  VPackageScanner.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 28/06/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit
import AVFoundation

class VPackageScanner: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    
    @IBOutlet weak var _viewScan: UIView!
    var _mode = String()
    var _delivery = s_delivery()
        var _listPackage = [s_package]()
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
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            //messageLabel.text = "No barcode/QR code is detected"
            return
        }
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if supportedBarCodes.contains(metadataObj.type) {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                if (self._mode == "CONSIGNE") {
                    self._listPackage = _modelDelivery.getPackageConsigne(refDelivery: _delivery._ref)
                }
                else if (self._mode == "LIVRAISON")
                {
                    self._listPackage = _modelDelivery.getPackageFromDeliver(refDelivery: _delivery._ref)
                }
                else {
                    self._listPackage = _modelDelivery.getPackageFromDelivery(ref: _delivery._ref)
                }
                if (productInList(ref: metadataObj.stringValue) == false) {
                    CreatePopUpWrongPackage(ref: metadataObj.stringValue)
                }
                else {
                    let refreshAlert = UIAlertController(title: "Etat du colis ", message: "ref : " + metadataObj.stringValue, preferredStyle: UIAlertControllerStyle.alert)
                    refreshAlert.addAction(UIAlertAction(title: "Bon état", style: .default,  handler: { (action: UIAlertAction!) in
                        _modelDelivery.setPackageCheck(refDelivery: self._delivery._ref, refPackage:  metadataObj.stringValue, checked: CHECKED)
                    }))
                    refreshAlert.addAction(UIAlertAction(title: "Mauvais état", style: .default, handler: { action in self.DamagedPackage(ref: metadataObj.stringValue) }))
                    refreshAlert.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil ))
                    present(refreshAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func productInList(ref : String) -> Bool {
        for elem in _listPackage {
            if (elem._reference == ref) {
                return true
            }
        }
        return false
    }
    
    func getPackageFromRef(ref : String) -> s_package {
        var tmp = s_package()
        for elem in _listPackage {
            if (elem._reference == ref) {
                tmp = elem
            }
        }
        return tmp
    }
    
    func ValidateTapped(ref : String)
    {
        
    }
    
    func CreatePopUpWrongPackage(ref: String) {
        let refreshAlert = UIAlertController(title: "Erreur", message: "La référence : " + ref + " ne fais pas partie des lots reçus", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Confirmer", style: .default, handler: nil))
        refreshAlert.addAction(UIAlertAction(title: "Annuer", style: .cancel, handler: nil))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func DamagedPackage(ref: String) {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VProduct") as! VProduct
        viewController._delivery = _delivery
        viewController._package = getPackageFromRef(ref: ref)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
