//
//  UiviewController+Extension.swift
//  URLShortener
//
//  Created by SiNguyen on 1/17/21.
//

import Foundation
import UIKit

extension UIViewController {

    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(options[index])
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIView {

@IBInspectable var shadowRadius: CGFloat {
    get {
        return layer.shadowRadius
    }
    set {
        layer.shadowRadius = newValue
    }
}

@IBInspectable var shadowOpacity: Float {
    get {
        return layer.shadowOpacity
    }
    set {
        layer.shadowOpacity = newValue
    }
}

@IBInspectable var shadowOffset: CGSize {
    get {
        return layer.shadowOffset
    }
    set {
        layer.shadowOffset = newValue
    }
}

@IBInspectable var maskToBound: Bool {
    get {
        return layer.masksToBounds
    }
    set {
        layer.masksToBounds = newValue
    }
}
    @IBInspectable var shadowColor: UIColor?{
            set {
                guard let uiColor = newValue else { return }
                layer.shadowColor = uiColor.cgColor
            }
            get{
                guard let color = layer.shadowColor else { return nil }
                return UIColor(cgColor: color)
            }
        }
}
