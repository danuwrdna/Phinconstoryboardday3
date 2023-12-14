import UIKit

class RecentlyPlayedCollection: UICollectionViewCell {

    @IBOutlet weak var imgRecentlyPlayed: UIImageView!
    @IBOutlet weak var labelRecentlyPlayed: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        border()
    }

}
extension RecentlyPlayedCollection{
    func border(){
        imgRecentlyPlayed.layer.cornerRadius = 10
        imgRecentlyPlayed.layer.shadowColor = UIColor.black.cgColor
        imgRecentlyPlayed.layer.shadowOpacity = 0.5
        imgRecentlyPlayed.layer.shadowRadius = 5.0
        imgRecentlyPlayed.layer.shadowOffset = CGSize(width: 0, height: 5.0)
    }
}
