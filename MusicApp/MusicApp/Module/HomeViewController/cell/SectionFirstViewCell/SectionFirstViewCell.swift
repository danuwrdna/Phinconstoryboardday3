import UIKit
import CoreData
import RxSwift
import RxCocoa
protocol SectionFirstViewCellDelegate {
    func didSelectItemAt(artist: String)
}
class SectionFirstViewCell: UITableViewCell {
    @IBOutlet weak var sectionFirstViewCollection: UICollectionView!
    var homeViewModel: HomeViewModel!
    var delegate: SectionFirstViewCellDelegate?
    private var coreDataArray: [Music] = [] {
        didSet {
            sectionFirstViewCollection.reloadData()
        }
    }
    private var apiData: [ArtistApi] = [] {
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
    func passApiData(data: [ArtistApi]) {
            self.apiData = data
        }
}
extension SectionFirstViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func delegateCollection(){
        sectionFirstViewCollection.delegate = self
        sectionFirstViewCollection.dataSource = self
        sectionFirstViewCollection.registerCellWithNib(SectionFirstViewCollection.self)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sectionFirstViewCollection.dequeueReusableCell(withReuseIdentifier: "SectionFirstViewCollection", for: indexPath) as! SectionFirstViewCollection
        let artist = apiData[indexPath.item]
        cell.textFirstLabel?.text = artist.name
        if let imageUrl = artist.picture {
            let url = URL(string: imageUrl)
            cell.imgViewFirstCollection?.kf.setImage(with: url)
        } else {
            cell.imgViewFirstCollection?.image = UIImage(named: "placeholderImage")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDatum = apiData[indexPath.item]
        if let title = selectedDatum.name{
            delegate?.didSelectItemAt(artist: title)
            NotificationCenter.default.post(name: NSNotification.Name("CollectionViewItemSelected"), object: title)
    
        }
    }
    
}
extension SectionFirstViewCell {
    internal func passData(data: [Music]) {
        self.coreDataArray = data
    }
    internal func passApiData(dataApi: [ArtistApi]) {
        self.apiData = dataApi
        sectionFirstViewCollection.reloadData()
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
