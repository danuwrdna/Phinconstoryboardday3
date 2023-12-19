import UIKit

class CmTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCollection: UIImageView!
    @IBOutlet weak var labelCollection: UILabel!
    @IBOutlet weak var subLabelCollection: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       setupSize()
        borderImg()
    }
}
extension CmTableViewCell{
    func setupSize(){
        imgCollection.clipsToBounds = true
        imgCollection.layer.masksToBounds = true
        imgCollection.layer.shouldRasterize = false
       
    }
    func borderImg(){
        imgCollection.layer.cornerRadius = imgCollection.frame.height / 2
    }
}
