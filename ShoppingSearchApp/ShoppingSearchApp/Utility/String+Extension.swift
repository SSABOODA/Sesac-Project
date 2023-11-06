//
//  String+Extension.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/08.
//

import Foundation

extension String {
    func removeHtmlTag() -> String {
        let result = self.replacingOccurrences(
            of: "<[^>]+>|&quot;",
            with: "",
            options: .regularExpression,
            range: nil
        )
        return result
    }
    
    func convertNumberFormatStyleToDecimal() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let price = Int(self) else { return "" }
        guard let result = numberFormatter.string(from: NSNumber(value: price)) else { return "" }
        return result
    }
   
}
