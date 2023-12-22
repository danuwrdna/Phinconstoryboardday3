import UIKit
import CoreData
import RxSwift
import RxCocoa
protocol SectionFirstViewCellDelegate {
    func didSelectItemAt(artist: String)
}
class SectionFirstViewCell: UITableViewCell {
    @IBOutlet weak var sectionFirstViewCollection: UICollectionView!
  
    var delegate: SectionFirstViewCellDelegate?
    private var coreDataArray: [Music] = [] {
        didSet {
            sectionFirstViewCollection.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        
    }
}
extension SectionFirstViewCell{

}
extension SectionFirstViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func delegateCollection(){
        sectionFirstViewCollection.delegate = self
        sectionFirstViewCollection.dataSource = self
        sectionFirstViewCollection.registerCellWithNib(SectionFirstViewCollection.self)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sectionFirstViewCollection.dequeueReusableCell(withReuseIdentifier: "SectionFirstViewCollection", for: indexPath) as! SectionFirstViewCollection
        let datum = coreDataArray[indexPath.item]
        cell.textFirstLabel?.text = datum.title
        if let imageUrl = datum.image {
            let url = URL(string: imageUrl)
            cell.imgViewFirstCollection?.kf.setImage(with: url)
        } else {
            cell.imgViewFirstCollection?.image = UIImage(named: "placeholderImage")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDatum = coreDataArray[indexPath.item]
        if let title = selectedDatum.title{
            delegate?.didSelectItemAt(artist: title)
            NotificationCenter.default.post(name: NSNotification.Name("CollectionViewItemSelected"), object: title)
    
        }
    }
    
}
extension SectionFirstViewCell {
    internal func passData(data: [Music]) {
        self.coreDataArray = data
    }
}

//extension SectionFirstViewCell{
//    func layout(){
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 10
//        // Ganti nilai UIEdgeInsets sesuai dengan kebutuhan Anda
//        // Setelah itu, atur layout ke UICollectionView Anda
//        sectionFirstViewCollection.collectionViewLayout = layout
//
//    }
//}
