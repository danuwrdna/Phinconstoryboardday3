import UIKit
import CoreData
class BrowseCell: UITableViewCell {
    private var coreDataArray: [Music] = [] {
        didSet {
           collectionBrowse.reloadData()
        }
    }
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
        return coreDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionBrowse.dequeueReusableCell(withReuseIdentifier: "BrowseCollection", for: indexPath) as! BrowseCollection// Replace YourCollectionViewCell with the actual name of your cell class
        cell.modelImgViewModel = ModelImgViewModel()
        let datum = coreDataArray[indexPath.item]
        cell.labelBrowse?.text = datum.subtitle
        if let imageUrl = datum.image {
            let url = URL(string: imageUrl)
            cell.imgBrowse?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgBrowse?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
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
}
