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
}
