//
//  String+Extension.swift
//  ChatApp
//
//  Created by Apple on 07/03/2022.
//

import Foundation
extension String {
    var removeEmailSuffix: String {
        // Remove Email Suffix, will remove all characters after '@'
        var string = self
        if let emailSuffix = range(of: "@") {
            string.removeSubrange(emailSuffix.lowerBound..<endIndex)
        }
        return string
    }
}
