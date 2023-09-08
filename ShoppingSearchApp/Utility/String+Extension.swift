//
//  String+Extension.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/08.
//

import Foundation

extension String {
  
  // MARK: Initializers
  
  init?(htmlEncodedString: String) {
    guard let data = htmlEncodedString.data(using: .utf8) else { return nil }
    
    let options: [NSAttributedString.DocumentReadingOptionKey:Any] = [
      .documentType: NSAttributedString.DocumentType.html,
      .characterEncoding: String.Encoding.utf8.rawValue
    ]
    guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
      return nil
    }
    self.init(attributedString.string)
  }
}
