import UIKit

class BrowseCollection: UICollectionViewCell {

    @IBOutlet weak var imgBrowse: UIImageView!
    @IBOutlet weak var labelBrowse: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       rotate()
    }

}
extension BrowseCollection{
    func rotate(){
        let rotationAngle: CGFloat = -30 * .pi / 180
        imgBrowse.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }
}
