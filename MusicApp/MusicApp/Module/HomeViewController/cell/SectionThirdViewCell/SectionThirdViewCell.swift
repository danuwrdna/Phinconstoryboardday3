import UIKit
import CoreData
protocol SectionThirdViewCellDelegate {
    func didSelectItemAt(subTitle: String)
}
class SectionThirdViewCell: UITableViewCell {
    private var coreDataArray: [Music] = [] {
        didSet {
            collectionSectionThird.reloadData()
            coreDataHead()
        }
    }
    var delegate: SectionThirdViewCellDelegate?
    @IBOutlet weak var collectionSectionThird: UICollectionView!
    @IBOutlet weak var imgCollectionSectionThird: UIImageView!
    @IBOutlet weak var labelArtistImgCollectionThird: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        coreDataHead()
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
        return coreDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionSectionThird.dequeueReusableCell(withReuseIdentifier: "SectionThirdViewCollection", for: indexPath) as! SectionThirdViewCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = coreDataArray[indexPath.item]
        cell.textLabelCollectionThird?.text = datum.subtitle
        if let imageUrl = datum.image {
            let url = URL(string: imageUrl)
            cell.imgCollectionThird?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgCollectionThird?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDatum = coreDataArray[indexPath.item]
        if let subTitle = selectedDatum.subtitle{
            delegate?.didSelectItemAt(subTitle: subTitle)
            NotificationCenter.default.post(name: NSNotification.Name("CollectionViewItemSelected"), object: subTitle)
        }
    }
    
    
}
extension SectionThirdViewCell{
}
extension SectionThirdViewCell{
    func coreDataHead(){
        if let firstMusicItem = coreDataArray.first{
            labelArtistImgCollectionThird.text = firstMusicItem.title
            
            if let imageUrl = firstMusicItem.image {
                let url = URL(string: imageUrl)
                imgCollectionSectionThird.kf.setImage(with: url)
            } else {
                // Handle case when image URL is not available
                imgCollectionSectionThird.image = UIImage(named: "placeholderImage")
            }
        }
    }
    func border(){
        imgCollectionSectionThird.layer.cornerRadius = 16
    }
}
extension SectionThirdViewCell{
    internal func passData(data: [Music]) {
        self.coreDataArray = data
    }
}
