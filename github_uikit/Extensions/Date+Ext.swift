//
//  Date+Ext.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 02/06/24.
//

import Foundation

extension Date {
    
    func getFormattedString(using pattern: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        return dateFormatter.string(from: self)
    }
}
