import UIKit
import CoreData
class SectionFourViewCell: UITableViewCell {
    private var coreDataArray: [Music] = [] {
        didSet {
            collectionFourCell.reloadData()
        }
    }
    @IBOutlet weak var collectionFourCell: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       delegateCollection()
    }
}
extension SectionFourViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionFourCell.delegate = self
        collectionFourCell.dataSource = self
       collectionFourCell.registerCellWithNib(SectionFourViewCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionFourCell.dequeueReusableCell(withReuseIdentifier: "SectionFourViewCollection", for: indexPath) as! SectionFourViewCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = coreDataArray[indexPath.item]
        cell.labelTextCollectionFour.text = datum.subtitle
        if let imageUrl = datum.image {
            let url = URL(string: imageUrl)
            cell.imgCollectionFour?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgCollectionFour?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    }
extension SectionFourViewCell{
    internal func passData(data: [Music]) {
        self.coreDataArray = data
    }
}
