import UIKit

class SectionFirstViewCollection: UICollectionViewCell {

    @IBOutlet weak var imgViewCollection: UIImageView!
    @IBOutlet weak var imgViewFirstCollection: UIImageView!
    @IBOutlet weak var textFirstLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       borderImg()
       
    }
}
extension SectionFirstViewCollection{
    func borderImg(){
        imgViewCollection.layer.cornerRadius = 10
        imgViewCollection.clipsToBounds = true
        imgViewFirstCollection.layer.cornerRadius = 10
     
    }

}
