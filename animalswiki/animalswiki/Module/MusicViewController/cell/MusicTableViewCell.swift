
import UIKit
class MusicTableViewCell: UITableViewCell {
    var navigationDelegate: UINavigationController?
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var viewTB: UIView!
    @IBOutlet weak var viewSW: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        borderImg()
        borderTable()
        
    }
}
extension MusicTableViewCell{
    func borderImg(){
        imgView.layer.cornerRadius = 0
        imgView.clipsToBounds = true

    }
    
    func borderTable(){
        viewSW.layer.cornerRadius = 16
        viewSW.layer.shadowColor = UIColor.black.cgColor
        viewSW.layer.shadowOpacity = 0.5
        viewSW.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewSW.layer.shadowRadius = 4.0        
       viewSW.layer.masksToBounds = false
       viewTB.layer.cornerRadius = 16
       viewTB.layer.masksToBounds = true
    }
}

