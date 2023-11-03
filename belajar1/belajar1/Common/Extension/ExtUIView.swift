import Foundation
import UIKit

extension UIView {
    func roundedCorner(_ borderWith: CGFloat = 1.0, _ cornerRadius: CGFloat = 16) {
        self.layer.borderWidth = borderWith
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
}
