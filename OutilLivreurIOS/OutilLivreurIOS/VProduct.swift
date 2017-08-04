//
//  VProduct.swift
//  OutilLivreurIOS
//
//  Created by Antoine Millet on 28/06/2017.
//  Copyright © 2017 Antoine Millet. All rights reserved.
//

import UIKit




class VProduct: UIViewController {

    @IBOutlet weak var _segmentedBar: UISegmentedControl!
    @IBOutlet weak var _viewSegmentedBar: UIView!
    var _delivery = s_delivery()
    var _package = s_package()
    var _mode = String()
    
    lazy var _viewListProduct: VProductList = {
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "VProductList") as! VProductList
        viewController._delivery = self._delivery
        viewController._package = self._package
        viewController._mode = self._mode
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var _viewScannerProduct: VProductScanner = {
        let storyboard = UIStoryboard(name:"Main",bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "VProductScanner") as! VProductScanner
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    @IBOutlet weak var PopUpDeliver: UIBarButtonItem!

    @IBAction func PopUpDidTouched(_ sender: Any) {
        performSegue(withIdentifier: "SegueDeliver", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueDeliver"{
            if let nextViewController = segue.destination as? VPopUp{
                nextViewController._delivery = self._delivery
                nextViewController._package = self._package
            }
        }
    }
    
    
    override func viewDidLoad() {
        if (_mode == "CONSIGNE"){
            if let button = self.navigationItem.rightBarButtonItem {
                button.isEnabled = false
                button.tintColor = UIColor.clear
            }
        }
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.title = "Articles"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self._viewListProduct.view.isHidden = !(_segmentedBar.selectedSegmentIndex == 0)
        self._viewScannerProduct.view.isHidden = (_segmentedBar.selectedSegmentIndex == 0)
        weak var weakSelf = self
        navigationItem.leftBarButtonItems = CustomBackButton.createWithText(text: "Lots", color: UIColor.red, target: weakSelf, action: #selector(VProduct.goBack))

    }
    
    
    
    func goBack() {
        if (_mode == DAMAGED) {
            if (_viewListProduct.getStateBtn() == false) {
                let str = "Si la liste des produits n'est pas validé le lot ne sera pas considéré comme endomagé.\n\nEtes-vous sur de vouloir continuer ?"
                let refreshAlert = UIAlertController(title: "Information", message: str, preferredStyle: UIAlertControllerStyle.alert)
                refreshAlert.addAction(UIAlertAction(title: "Continuer", style: .default, handler: {(action: UIAlertAction!) in
                    _ = self.navigationController?.popViewController(animated: true)
                }))
                refreshAlert.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil ))
                present(refreshAlert, animated: true, completion: nil)
            }
            else {
            _ = navigationController?.popViewController(animated: true)
            }
        }
        else {
        _ = navigationController?.popViewController(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SelectionDidChanged(_ sender: Any) {
        self._viewListProduct.view.isHidden = !(_segmentedBar.selectedSegmentIndex == 0)
        self._viewListProduct.reload()
        self._viewScannerProduct.view.isHidden = (_segmentedBar.selectedSegmentIndex == 0)
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        view.insertSubview(childViewController.view, belowSubview: self._viewSegmentedBar)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }

}

class CustomBackButton: NSObject {
    
    class func createWithText(text: String, color: UIColor, target: AnyObject?, action: Selector) -> [UIBarButtonItem] {
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -8
        let backArrowImage = imageOfBackArrow(color: color)
        let backArrowButton = UIBarButtonItem(image: backArrowImage, style: UIBarButtonItemStyle.plain, target: target, action: action)
        let backTextButton = UIBarButtonItem(title: text, style: UIBarButtonItemStyle.plain , target: target, action: action)
        backTextButton.setTitlePositionAdjustment(UIOffset(horizontal: -12.0, vertical: 0.0), for: UIBarMetrics.default)
        return [negativeSpacer, backArrowButton, backTextButton]
    }
    
    class func createWithImage(image: UIImage, color: UIColor, target: AnyObject?, action: Selector) -> [UIBarButtonItem] {
        // recommended maximum image height 22 points (i.e. 22 @1x, 44 @2x, 66 @3x)
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -8
        let backArrowImageView = UIImageView(image: imageOfBackArrow(color: color))
        let backImageView = UIImageView(image: image)
        let customBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 22 + backImageView.frame.width, height: 22))
        backImageView.frame = CGRect(x: 22, y: 0, width: backImageView.frame.width, height: backImageView.frame.height)
        customBarButton.addSubview(backArrowImageView)
        customBarButton.addSubview(backImageView)
        customBarButton.addTarget(target, action: action, for: .touchUpInside)
        return [negativeSpacer, UIBarButtonItem(customView: customBarButton)]
    }
    
    private class func drawBackArrow(_ frame: CGRect = CGRect(x: 0, y: 0, width: 14, height: 22), color: UIColor = UIColor(hue: 0.59, saturation: 0.674, brightness: 0.886, alpha: 1), resizing: ResizingBehavior = .AspectFit) {
        /// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        /// Resize To Frame
        context.saveGState()
        let resizedFrame = resizing.apply(CGRect(x: 0, y: 0, width: 14, height: 22), target: frame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        let resizedScale = CGSize(width: resizedFrame.width / 14, height: resizedFrame.height / 22)
        context.scaleBy(x: resizedScale.width, y: resizedScale.height)
        
        /// Line
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 9, y: 9))
        line.addLine(to: CGPoint.zero)
        context.saveGState()
        context.translateBy(x: 3, y: 11)
        line.lineCapStyle = .square
        line.lineWidth = 3
        color.setStroke()
        line.stroke()
        context.restoreGState()
        
        /// Line Copy
        let lineCopy = UIBezierPath()
        lineCopy.move(to: CGPoint(x: 9, y: 0))
        lineCopy.addLine(to: CGPoint(x: 0, y: 9))
        context.saveGState()
        context.translateBy(x: 3, y: 2)
        lineCopy.lineCapStyle = .square
        lineCopy.lineWidth = 3
        color.setStroke()
        lineCopy.stroke()
        context.restoreGState()
        
        context.restoreGState()
    }
    
    private class func imageOfBackArrow(_ size: CGSize = CGSize(width: 14, height: 22), color: UIColor = UIColor(hue: 0.59, saturation: 0.674, brightness: 0.886, alpha: 1), resizing: ResizingBehavior = .AspectFit) -> UIImage {
        var image: UIImage
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        drawBackArrow(CGRect(origin: CGPoint.zero, size: size), color: color, resizing: resizing)
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    private enum ResizingBehavior {
        case AspectFit /// The content is proportionally resized to fit into the target rectangle.
        case AspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case Stretch /// The content is stretched to match the entire target rectangle.
        case Center /// The content is centered in the target rectangle, but it is NOT resized.
        
        func apply(_ rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .AspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .AspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .Stretch:
                break
            case .Center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}


