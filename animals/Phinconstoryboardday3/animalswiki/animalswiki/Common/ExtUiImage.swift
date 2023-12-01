//
//  ExtUiImage.swift
//  animalswiki
//
//  Created by Phincon on 21/11/23.
//

import Foundation
import UIKit
extension UIImage {
    func scaledToSize(_ newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
