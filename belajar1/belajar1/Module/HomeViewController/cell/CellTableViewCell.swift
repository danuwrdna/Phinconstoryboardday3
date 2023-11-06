import UIKit

class CellTableViewCell: UITableViewCell {
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var subjudul: UILabel!
    @IBOutlet weak var judul: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
