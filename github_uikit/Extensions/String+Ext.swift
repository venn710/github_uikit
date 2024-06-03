//
//  String+Ext.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 10/04/24.
//

import Foundation

extension String {
    
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    func getDateObject(using pattern: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
    
    
    func convertTo(from format1: String, to format2: String) -> String {
        let dateObject = getDateObject(using: format1)
        return dateObject?.getFormattedString(using: format2) ?? "N/A"
    }
}
