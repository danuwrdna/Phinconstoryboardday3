import UIKit
import CoreData
protocol PopularArtistDelegateCell {
    func didSelectItemAt(subTitle: String)
}
class PopularArtistCell: UITableViewCell {
    private var coreDataArray: [Music] = [] {
        didSet {
           collectionPopularArtist.reloadData()
        }
    }
    var delegate: PopularArtistDelegateCell?
    @IBOutlet weak var collectionPopularArtist: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromCoreData()
    }    
}
extension PopularArtistCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionPopularArtist.delegate = self
        collectionPopularArtist.dataSource = self
        collectionPopularArtist.registerCellWithNib(PopularArtistCollection.self)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionPopularArtist.dequeueReusableCell(withReuseIdentifier: "PopularArtistCollection", for: indexPath) as! PopularArtistCollection
        cell.modelImgViewModel = ModelImgViewModel()
        let datum = coreDataArray[indexPath.item]
        cell.labelPopularArtist?.text = datum.subtitle
        if let imageUrl = datum.image{
            let url = URL(string: imageUrl)
            cell.imgPopularArtist?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgPopularArtist?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDatum = coreDataArray[indexPath.item]
        if let subTitle = selectedDatum.subtitle{
            delegate?.didSelectItemAt(subTitle: subTitle)
        }
    }
    
    
}
extension PopularArtistCell{
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
           coreDataArray = result as! [Music]
         collectionPopularArtist.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
    }
}
extension PopularArtistCell{
    internal func passData(data: [Music]) {
        self.coreDataArray = data
    }
}
