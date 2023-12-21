import UIKit
import CoreData
protocol SectionSecondViewCellDelegate {
    func didSelectItemAt(subTitle: String)
}
class SectionSecondViewCell: UITableViewCell {
    private var coreDataArray: [Music] = [] {
        didSet {
           collectionSecondCell.reloadData()
        }
    }
    @IBOutlet weak var collectionSecondCell: UICollectionView!
    var data: [Music] = []
    var didSelectItem: ((Music) -> Void)?
    var delegate: SectionSecondViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
    }
}
extension SectionSecondViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionSecondCell.delegate = self
        collectionSecondCell.dataSource = self
        collectionSecondCell.registerCellWithNib(SectionSecondViewCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionSecondCell.dequeueReusableCell(withReuseIdentifier: "SectionSecondViewCollection", for: indexPath) as! SectionSecondViewCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = coreDataArray[indexPath.item]
        didSelectItem?(datum)
        cell.textLabelSecondCollection?.text = datum.subtitle
        if let imageUrl = datum.image {
            let url = URL(string: imageUrl)
            cell.imgViewSecondCollection?.kf.setImage(with: url)
        } else {
            cell.imgViewSecondCollection?.image = UIImage(named: "placeholderImage")
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
extension SectionSecondViewCell{
    internal func passData(data: [Music]) {
        self.coreDataArray = data
    }
}
