//
//  String+Extension.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/08.
//

import Foundation

extension String {
    func removeHtmlTag() -> String {
        print(self)
        let result = self.replacingOccurrences(
            of: "<[^>]+>|&quot;",
            with: "",
            options: .regularExpression,
            range: nil
        )
        return result
    }
   
}
