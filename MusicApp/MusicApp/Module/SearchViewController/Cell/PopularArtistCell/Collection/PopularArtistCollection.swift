import UIKit

class PopularArtistCollection: UICollectionViewCell {
    var modelImgViewModel: ModelImgViewModel! {
        didSet {
            updateBackgroundImage()
        }
    }
    @IBOutlet weak var imgPopularArtist: UIImageView!
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var labelPopularArtist: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        rotate()
        borderImg()
        borderImgPopularArtist()
    }
    
}
extension PopularArtistCollection{
    private func updateBackgroundImage() {
        guard let model = modelImgViewModel,
              let randomImage = model.imageArray.randomElement()?.image else {
            return
        }
        
        imgBG.image = UIImage(named: randomImage)
    }
    func rotate(){
        let rotationAngle: CGFloat = -30 * .pi / 180
        imgPopularArtist.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }
    func borderImg(){
        imgBG.layer.cornerRadius = 5
    }
    func borderImgPopularArtist(){
        imgPopularArtist.layer.cornerRadius = 10
        imgPopularArtist.clipsToBounds = true
        imgPopularArtist.layer.masksToBounds = true
        imgPopularArtist.layer.shadowColor = UIColor.black.cgColor
        imgPopularArtist.layer.shadowOpacity = 0.5
        imgPopularArtist.layer.shadowOffset = CGSize(width: 0, height: 2)
        imgPopularArtist.layer.shadowRadius = 4.0
        imgPopularArtist.layer.shouldRasterize = true
        imgPopularArtist.layer.rasterizationScale = UIScreen.main.scale
    }
}
