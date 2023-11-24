

import UIKit


class DpViewCell: UICollectionViewCell {
    var image2: UIImage?
    @IBOutlet weak var viewImages: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewImages.image = image2
    }

}
