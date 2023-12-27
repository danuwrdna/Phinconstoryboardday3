import UIKit
import CoreData
protocol SectionThirdViewCellDelegate {
    func didSelectItemAt(subTitle: String)
}
class SectionThirdViewCell: UITableViewCell {
    private var coreDataArray: [Music] = [] {
        didSet {
            collectionSectionThird.reloadData()
        }
    }
    private var apiData: [PlaylistAPI] = [] {
        didSet {
            collectionSectionThird.reloadData()
        }
    }
    var delegate: SectionThirdViewCellDelegate?
    @IBOutlet weak var collectionSectionThird: UICollectionView!
    @IBOutlet weak var imgCollectionSectionThird: UIImageView!
    @IBOutlet weak var labelArtistImgCollectionThird: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        border()
        
    }
}
extension SectionThirdViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionSectionThird.delegate = self
        collectionSectionThird.dataSource = self
        collectionSectionThird.registerCellWithNib(SectionThirdViewCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionSectionThird.dequeueReusableCell(withReuseIdentifier: "SectionThirdViewCollection", for: indexPath) as! SectionThirdViewCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let playlistDat = apiData[indexPath.item]
        cell.textLabelCollectionThird?.text = playlistDat.title
        if let imageUrl = playlistDat.picture {
            let url = URL(string: imageUrl)
            cell.imgCollectionThird?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgCollectionThird?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playlist = apiData[indexPath.item]
        if let subTitle = playlist.title{
            delegate?.didSelectItemAt(subTitle: subTitle)
        }
    }
}
extension SectionThirdViewCell{
    func border(){
        imgCollectionSectionThird.layer.cornerRadius = 16
    }
}
extension SectionThirdViewCell{
    internal func passData(data: [Music]) {
        self.coreDataArray = data
    }
internal func passApiData(dataPlaylist: [PlaylistAPI]) {
    self.apiData = dataPlaylist
    collectionSectionThird.reloadData()
    }
}
extension SectionThirdViewCell{
    
}

