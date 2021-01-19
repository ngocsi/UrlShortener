//
//  Date_Extension.swift
//  URLShortener
//
//  Created by SiNguyen on 1/17/21.
//

import Foundation

enum DateFormat: String {
  case date           = "dd-MM-yyyy"
  case dateUrl     = "dd/MMM/yyyy"
}

extension Date {
    func stringFromDate(stringFormatter : String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = stringFormatter
        let myStringafd = formatter.string(from: self)
        return myStringafd
    }
}
