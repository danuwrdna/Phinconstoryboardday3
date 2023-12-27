import UIKit

class SectionSecondViewCollection: UICollectionViewCell {
    @IBOutlet weak var imgViewSecondCollection: UIImageView!
    @IBOutlet weak var textLabelSecondCollection: UILabel!
    @IBOutlet weak var labelDataksng: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        border()
        
    }
    func border(){
        imgViewSecondCollection.layer.cornerRadius = 10
        imgViewSecondCollection.clipsToBounds = true
        imgViewSecondCollection.layer.masksToBounds = true
        imgViewSecondCollection.layer.shadowColor = UIColor.black.cgColor
        imgViewSecondCollection.layer.shadowOpacity = 0.5
        imgViewSecondCollection.layer.shadowOffset = CGSize(width: 0, height: 2)
        imgViewSecondCollection.layer.shadowRadius = 4.0
        imgViewSecondCollection.layer.shouldRasterize = true
        imgViewSecondCollection.layer.rasterizationScale = UIScreen.main.scale
    
    }

}
