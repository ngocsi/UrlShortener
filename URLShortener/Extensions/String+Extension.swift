//
//  String+Extension.swift
//  URLShortener
//
//  Created by SiNguyen on 1/17/21.
//

import Foundation
import UIKit

extension String {
    var validURL: Bool {
        get {
            let regEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx])
            return predicate.evaluate(with: self)
        }
    }
}

extension UILabel {
    func setDifferentColor(string: String, location: Int, length: Int){
        let attText = NSMutableAttributedString(string: string)
        attText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:location,length:length))
        attributedText = attText
    }
}
