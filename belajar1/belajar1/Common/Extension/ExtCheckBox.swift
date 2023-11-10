import Foundation
import UIKit

final class CircularCheckbox: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.cornerRadius = frame.size.width / 2.0
        backgroundColor = .red
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    func setChecked(isChecked: Bool){
       if isChecked{
            backgroundColor = .systemBlue
        }
        else{
            backgroundColor = .red
        }
    }
}
