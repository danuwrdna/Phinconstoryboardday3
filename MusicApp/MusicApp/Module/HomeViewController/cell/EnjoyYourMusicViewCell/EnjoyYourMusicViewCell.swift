import UIKit
import CoreData
protocol EnjoyYourMusicViewCellDelegate {
    func didSelectItemAt(subTitle: String)
}
class EnjoyYourMusicViewCell: UITableViewCell {

    @IBOutlet weak var collectionSectionThird: UICollectionView!
    @IBOutlet weak var imgCollectionSectionThird: UIImageView!
    @IBOutlet weak var labelArtistImgCollectionThird: UILabel!
    
    private var coreDataArray: [Music] = [] {
        didSet {
            collectionSectionThird.reloadData()
        }
    }
    
    var apiData: [DataTracksItem] = [] {
        didSet {
            collectionSectionThird.reloadData()
        }
    }
    var delegate: EnjoyYourMusicViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        border()
        
    }
}
extension EnjoyYourMusicViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionSectionThird.delegate = self
        collectionSectionThird.dataSource = self
        collectionSectionThird.registerCellWithNib(EnjoyYourMusicViewCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionSectionThird.dequeueReusableCell(withReuseIdentifier: "EnjoyYourMusicViewCollection", for: indexPath) as! EnjoyYourMusicViewCollection
        let playlistDat = apiData[indexPath.item]
        cell.textLabelCollectionThird?.text = playlistDat.title
        if let imageUrl = playlistDat.album?.cover {
            let url = URL(string: imageUrl)
            cell.imgCollectionThird?.kf.setImage(with: url)
        } else {
            cell.imgCollectionThird?.image = UIImage(named: "placeholderImage")
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
extension EnjoyYourMusicViewCell{
    func border(){
        imgCollectionSectionThird.layer.cornerRadius = 16
    }
}
extension EnjoyYourMusicViewCell{
    internal func passData(data: [Music]) {
        self.coreDataArray = data
    }
    
    internal func passApiData(dataPlaylist: [DataTracksItem]) {
        self.apiData = dataPlaylist
        collectionSectionThird.reloadData()
    }
}
extension EnjoyYourMusicViewCell{
    
}

