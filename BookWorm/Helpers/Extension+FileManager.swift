//
//  Extension+FileManager.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/09/05.
//

import UIKit

extension UIViewController {
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch  let error {
            print("file save error", error)
        }
    }
}


