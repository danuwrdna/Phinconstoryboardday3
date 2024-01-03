import UIKit
import CoreData
import RxSwift
import RxCocoa
protocol ListenYourWayViewCellDelegate {
    func didSelectItemAt(artist: String)
}
class ListenYourWayViewCell: UITableViewCell {
   
   
    @IBOutlet weak var collectionViewListenYourWay: UICollectionView!
    
    var homeViewModel: HomeViewModel!
    var delegate: ListenYourWayViewCellDelegate?
    private var coreDataArray: [Music] = [] {
        didSet {
            collectionViewListenYourWay.reloadData()
        }
    }
    private var apiData: [ArtistApi] = [] {
        didSet {
            collectionViewListenYourWay.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        
    }
}
extension ListenYourWayViewCell{
    func passApiData(data: [ArtistApi]) {
            self.apiData = data
        }
}
extension ListenYourWayViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func delegateCollection(){
        collectionViewListenYourWay.delegate = self
        collectionViewListenYourWay.dataSource = self
        collectionViewListenYourWay.registerCellWithNib(ListenYourWayCollectionView.self)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewListenYourWay.dequeueReusableCell(withReuseIdentifier: "ListenYourWayCollectionView", for: indexPath) as! ListenYourWayCollectionView
        let artist = apiData[indexPath.item]
        cell.labelListenYourWay?.text = artist.name
        if let imageUrl = artist.picture {
            let url = URL(string: imageUrl)
            cell.imgListenYourWayCollection?.kf.setImage(with: url)
        } else {
            cell.imgListenYourWayCollection?.image = UIImage(named: "placeholderImage")
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
extension ListenYourWayViewCell{
    internal func passData(data: [Music]) {
        self.coreDataArray = data
    }
    internal func passApiData(dataApi: [ArtistApi]) {
        self.apiData = dataApi
        collectionViewListenYourWay.reloadData()
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
