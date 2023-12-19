import UIKit
import CoreData
class SectionFourViewCell: UITableViewCell {
    var data: [Music] = []
    @IBOutlet weak var collectionFourCell: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       delegateCollection()
        fetchDataFromCoreData()
    }
}
extension SectionFourViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionFourCell.delegate = self
        collectionFourCell.dataSource = self
       collectionFourCell.registerCellWithNib(SectionFourViewCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionFourCell.dequeueReusableCell(withReuseIdentifier: "SectionFourViewCollection", for: indexPath) as! SectionFourViewCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        cell.labelTextCollectionFour.text = datum.title
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
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
           data = result as! [Music]
         collectionFourCell.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
    }
}
