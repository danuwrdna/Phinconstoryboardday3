import UIKit

class ExploreCollection: UICollectionViewCell {
    @IBOutlet weak var labelSubTitleExplore: UILabel!
    @IBOutlet weak var labelTitleExplore: UILabel!
    @IBOutlet weak var imgExplore: UIImageView!
    @IBOutlet weak var viewExplore: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        border()
    }
}
extension ExploreCollection{
    func border(){
        imgExplore.layer.cornerRadius = 10
        imgExplore.layer.shadowColor = UIColor.black.cgColor
        imgExplore.layer.shadowOpacity = 0.5
        imgExplore.layer.shadowRadius = 5.0
        imgExplore.layer.shadowOffset = CGSize(width: 0, height: 5.0)
    }
}
