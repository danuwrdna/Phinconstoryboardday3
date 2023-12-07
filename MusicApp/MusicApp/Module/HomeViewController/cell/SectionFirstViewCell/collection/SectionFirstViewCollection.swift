import UIKit

class SectionFirstViewCollection: UICollectionViewCell {

    @IBOutlet weak var imgViewCollection: UIImageView!
    @IBOutlet weak var imgViewFirstCollection: UIImageView!
    @IBOutlet weak var textFirstLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //layout()
        // Initialization code
       
    }
}
//extension SectionFirstViewCollection{
//    func layout(){
//        viewCollectionHighlight.layer.cornerRadius = 16
//        viewCollectionHighlight.layer.masksToBounds = false
//        viewCollectionHighlight.layer.shadowColor = UIColor.black.cgColor
//        viewCollectionHighlight.layer.shadowOpacity = 0.5
//        viewCollectionHighlight.layer.shadowOffset = CGSize(width: 0, height: 2)
//        viewCollectionHighlight.layer.shadowRadius = 4.0
//        viewCollectionHighlight.layer.shouldRasterize = true
//        viewCollectionHighlight.layer.rasterizationScale = UIScreen.main.scale
//    }

