
import UIKit

class MusicTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var viewTB: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        borderImg()
        borderTable()
    }
}
extension MusicTableViewCell{
    func borderImg(){
        imgView.layer.cornerRadius = 16
    }
    func borderTable(){
       viewTB.layer.cornerRadius = 16
       viewTB.layer.masksToBounds = false
       viewTB.layer.shadowColor = UIColor.black.cgColor
       viewTB.layer.shadowOpacity = 0.5
       viewTB.layer.shadowOffset = CGSize(width: 0, height: 2)
       viewTB.layer.shadowRadius = 4.0
       viewTB.layer.shouldRasterize = true
       viewTB.layer.rasterizationScale = UIScreen.main.scale
    }
}
