import UIKit

class RecentlyPlayedViewCollection: UICollectionViewCell {
    
    @IBOutlet weak var imgViewRecentlyPlayed: UIImageView!
    @IBOutlet weak var labelRecentlyPlayed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        border()
        
    }
    
    func border(){
        imgViewRecentlyPlayed.layer.cornerRadius = 10
        imgViewRecentlyPlayed.clipsToBounds = true
        imgViewRecentlyPlayed.layer.masksToBounds = true
        imgViewRecentlyPlayed.layer.shadowColor = UIColor.black.cgColor
        imgViewRecentlyPlayed.layer.shadowOpacity = 0.5
        imgViewRecentlyPlayed.layer.shadowOffset = CGSize(width: 0, height: 2)
        imgViewRecentlyPlayed.layer.shadowRadius = 4.0
        imgViewRecentlyPlayed.layer.shouldRasterize = true
        imgViewRecentlyPlayed.layer.rasterizationScale = UIScreen.main.scale
    
    }

}
