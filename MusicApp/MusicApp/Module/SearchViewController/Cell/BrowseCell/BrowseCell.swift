import UIKit
import CoreData
protocol BrowseDelegateCell{
    func didSelectItemAt(subTitle: String)
}
class BrowseCell: UITableViewCell {
    private var coreDataArray: [Music] = [] {
        didSet {
            collectionBrowse.reloadData()
        }
    }
    private var genre: [DataGenre] = [] {
        didSet {
            collectionBrowse.reloadData()
        }
    }
    var delegate: BrowseDelegateCell?
    var colorModel = ModelImgViewModel()
    @IBOutlet weak var collectionBrowse: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromCoreData()
    }
}
extension BrowseCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionBrowse.delegate = self
        collectionBrowse.dataSource = self
        collectionBrowse.registerCellWithNib(BrowseCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionBrowse.dequeueReusableCell(withReuseIdentifier: "BrowseCollection", for: indexPath) as! BrowseCollection
        cell.modelImgViewModel = ModelImgViewModel()
        let dataGenre = genre[indexPath.item]
        cell.labelBrowse?.text = dataGenre.name
        if let imageUrl = dataGenre.picture{
            let url = URL(string: imageUrl)
            cell.imgBrowse?.kf.setImage(with: url)
        } else {
            cell.imgBrowse?.image = UIImage(named: "doc.text.image.fill")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDatum = genre[indexPath.item]
        if let subTitle = selectedDatum.name{
            delegate?.didSelectItemAt(subTitle: subTitle)
        }
    }
    
}
extension BrowseCell{
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
            coreDataArray = result as! [Music]
            collectionBrowse.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
    }
}
extension BrowseCell{
    internal func passData(data: [Music]) {
        self.coreDataArray = data
    }
    internal func genre(data: [DataGenre]) {
        self.genre = data
    }
}
