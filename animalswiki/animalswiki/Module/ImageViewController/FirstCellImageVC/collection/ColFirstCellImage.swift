import UIKit

class ColFirstCellImage: UICollectionViewCell {
    @IBOutlet weak var imageColF: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageColF.layer.cornerRadius = 30.0
    }

}
