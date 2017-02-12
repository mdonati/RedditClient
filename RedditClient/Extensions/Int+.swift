//
//  Int+.swift
//  RedditClient
//
//  Created by Mariano on 12/2/17.
//  Copyright © 2017 Zink Games. All rights reserved.
//

import Foundation

extension Int {
    
    struct DecimalNumberFormatter {
        static let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            return formatter
        }()
    }
    var decimalNumberString : String {
        return DecimalNumberFormatter.formatter.string(from: NSNumber(value: self))!
    }
    
}
