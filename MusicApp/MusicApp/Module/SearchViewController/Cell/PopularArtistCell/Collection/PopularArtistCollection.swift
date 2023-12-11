import UIKit

class PopularArtistCollection: UICollectionViewCell {
    @IBOutlet weak var imgPopularArtist: UIImageView!
    @IBOutlet weak var labelPopularArtist: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        rotate()
    }

}
extension PopularArtistCollection{
    func rotate(){
        let rotationAngle: CGFloat = -30 * .pi / 180
        imgPopularArtist.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }
}
