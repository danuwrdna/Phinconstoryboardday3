import UIKit

class SectionThirdViewCollection: UICollectionViewCell {
    @IBOutlet weak var textLabelCollectionThird: UILabel!
    @IBOutlet weak var imgCollectionThird: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        border()
    }
    func border(){
        imgCollectionThird.layer.cornerRadius = 10
        imgCollectionThird.clipsToBounds = true
        imgCollectionThird.layer.masksToBounds = true
        imgCollectionThird.layer.shadowColor = UIColor.black.cgColor
        imgCollectionThird.layer.shadowOpacity = 0.5
        imgCollectionThird.layer.shadowOffset = CGSize(width: 0, height: 2)
        imgCollectionThird.layer.shadowRadius = 4.0
        imgCollectionThird.layer.shouldRasterize = true
        imgCollectionThird.layer.rasterizationScale = UIScreen.main.scale
    }

}
