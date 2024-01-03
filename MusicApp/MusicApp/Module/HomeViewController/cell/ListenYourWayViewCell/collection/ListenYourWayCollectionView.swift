import UIKit

class ListenYourWayCollectionView: UICollectionViewCell {

    @IBOutlet weak var imgBGListenYourWayCollection: UIImageView!
   
    @IBOutlet weak var imgListenYourWayCollection: UIImageView!
    @IBOutlet weak var labelListenYourWay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       borderImg()
       
    }
}
extension ListenYourWayCollectionView{
    func borderImg(){
        imgListenYourWayCollection.layer.cornerRadius = 10
        imgListenYourWayCollection.clipsToBounds = true
        imgBGListenYourWayCollection.layer.cornerRadius = 10
     
    }

}
