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
        imgCollection.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imgCollection.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imgCollection.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    func borderImg(){
        imgCollection.layer.cornerRadius = 20
    }
}
