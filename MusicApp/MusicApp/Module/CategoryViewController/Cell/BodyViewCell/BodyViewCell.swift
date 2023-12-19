import UIKit
import CoreData
class BodyViewCell: UITableViewCell {
    var data: [Music] = []
    @IBOutlet weak var bodyCollectionCell: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromCoreData()
    }
}
extension BodyViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        bodyCollectionCell.delegate = self
        bodyCollectionCell.dataSource = self
        bodyCollectionCell.registerCellWithNib(BodyCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bodyCollectionCell.dequeueReusableCell(withReuseIdentifier: "BodyCollection", for: indexPath) as! BodyCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        cell.labelBodyCollection?.text = datum.subtitle
        if let imageUrl = datum.image{
            let url = URL(string: imageUrl)
            cell.imgBodyCollection?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgBodyCollection?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    
    
}
extension BodyViewCell{
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
           data = result as! [Music]
          bodyCollectionCell.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
    }
}
