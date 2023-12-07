import UIKit

class TopGenresCollection: UICollectionViewCell {

    @IBOutlet weak var imgTopGenreCollection: UIImageView!
    @IBOutlet weak var labelTextTopGenre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        rotate()
    }

}
extension TopGenresCollection{
    func rotate(){
        let rotationAngle: CGFloat = -30 * .pi / 180
        imgTopGenreCollection.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }
}
