import UIKit

class NewReleaseViewCollection: UICollectionViewCell {

    @IBOutlet weak var imgCollectionFour: UIImageView!
    @IBOutlet weak var labelTextCollectionFour: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        border()
    }
    func border(){
        imgCollectionFour.layer.cornerRadius = 10
        imgCollectionFour.clipsToBounds = true
        imgCollectionFour.layer.masksToBounds = true
        imgCollectionFour.layer.shadowColor = UIColor.black.cgColor
        imgCollectionFour.layer.shadowOpacity = 0.5
        imgCollectionFour.layer.shadowOffset = CGSize(width: 0, height: 2)
        imgCollectionFour.layer.shadowRadius = 4.0
        imgCollectionFour.layer.shouldRasterize = true
        imgCollectionFour.layer.rasterizationScale = UIScreen.main.scale
    }

}
