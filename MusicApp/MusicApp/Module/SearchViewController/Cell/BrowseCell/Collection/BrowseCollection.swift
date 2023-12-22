import UIKit

class BrowseCollection: UICollectionViewCell {
    var modelImgViewModel: ModelImgViewModel! {
        didSet {
            updateBackgroundImage()
        }
    }
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var imgBrowse: UIImageView!
    @IBOutlet weak var labelBrowse: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        rotate()
        borderImg()
        borderImgBrowse()
    }
    
}
extension BrowseCollection{
    private func updateBackgroundImage() {
        guard let model = modelImgViewModel,
              let randomImage = model.imageArray.randomElement()?.image else {
            return
        }
        
        imgBG.image = UIImage(named: randomImage)
    }
    func rotate(){
        let rotationAngle: CGFloat = -30 * .pi / 180
        imgBrowse.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }
    func borderImg(){
        imgBG.layer.cornerRadius = 5
    }
    func borderImgBrowse(){
        imgBrowse.layer.cornerRadius = 10
        imgBrowse.clipsToBounds = true
        imgBrowse.layer.masksToBounds = true
        imgBrowse.layer.shadowColor = UIColor.black.cgColor
        imgBrowse.layer.shadowOpacity = 0.5
        imgBrowse.layer.shadowOffset = CGSize(width: 0, height: 2)
        imgBrowse.layer.shadowRadius = 4.0
        imgBrowse.layer.shouldRasterize = true
        imgBrowse.layer.rasterizationScale = UIScreen.main.scale
    }
}
