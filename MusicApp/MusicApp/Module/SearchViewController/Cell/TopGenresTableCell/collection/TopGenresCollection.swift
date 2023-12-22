import UIKit

class TopGenresCollection: UICollectionViewCell {
    var modelImgViewModel: ModelImgViewModel! {
        didSet {
            updateBackgroundImage()
        }
    }
    @IBOutlet weak var imgTopGenreCollection: UIImageView!
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var labelTextTopGenre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        rotate()
        borderImg()
        borderImgTopGenreCollection()
    }
    
}
extension TopGenresCollection{
    private func updateBackgroundImage() {
        guard let model = modelImgViewModel,
              let randomImage = model.imageArray.randomElement()?.image else {
            return
        }
        
        imgBG.image = UIImage(named: randomImage)
    }
    func rotate(){
        let rotationAngle: CGFloat = -30 * .pi / 180
        imgTopGenreCollection.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }
    func borderImg(){
        imgBG.layer.cornerRadius = 5
    }
    func borderImgTopGenreCollection(){
        imgTopGenreCollection.layer.cornerRadius = 10
        imgTopGenreCollection.clipsToBounds = true
        imgTopGenreCollection.layer.masksToBounds = true
        imgTopGenreCollection.layer.shadowColor = UIColor.black.cgColor
        imgTopGenreCollection.layer.shadowOpacity = 0.5
        imgTopGenreCollection.layer.shadowOffset = CGSize(width: 0, height: 2)
        imgTopGenreCollection.layer.shadowRadius = 4.0
        imgTopGenreCollection.layer.shouldRasterize = true
        imgTopGenreCollection.layer.rasterizationScale = UIScreen.main.scale
    }
}
