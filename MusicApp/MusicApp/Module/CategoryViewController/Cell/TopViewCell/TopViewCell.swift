import UIKit
import CoreData
class TopViewCell: UITableViewCell {
    var data: [Music] = []
    @IBOutlet weak var collectionTopViewCell: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromCoreData()
    }
    
}
extension TopViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionTopViewCell.delegate = self
        collectionTopViewCell.dataSource = self
        collectionTopViewCell.registerCellWithNib(TopCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionTopViewCell.dequeueReusableCell(withReuseIdentifier: "TopCollection", for: indexPath) as! TopCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        cell.labelCollection?.text = datum.subtitle
        if let imageUrl = datum.image {
            let url = URL(string: imageUrl)
            cell.imgTop?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgTop?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    
    
}
extension TopViewCell{
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
           data = result as! [Music]
          collectionTopViewCell.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
    }
}
