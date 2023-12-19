import UIKit
import CoreData
protocol SectionSecondViewCellDelegate {
    func didSelectItemAt(image: String)
}

class SectionSecondViewCell: UITableViewCell {
    @IBOutlet weak var collectionSecondCell: UICollectionView!
    var data: [Music] = []
    var didSelectItem: ((Music) -> Void)?
    var delegate: SectionSecondViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        fetchDataFromCoreData()
        delegateCollection()
    }
}
extension SectionSecondViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionSecondCell.delegate = self
        collectionSecondCell.dataSource = self
        collectionSecondCell.registerCellWithNib(SectionSecondViewCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionSecondCell.dequeueReusableCell(withReuseIdentifier: "SectionSecondViewCollection", for: indexPath) as! SectionSecondViewCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        didSelectItem?(datum)
        cell.textLabelSecondCollection?.text = datum.title
        if let imageUrl = datum.image {
            let url = URL(string: imageUrl)
            cell.imgViewSecondCollection?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgViewSecondCollection?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDatum = data[indexPath.item]
        delegate?.didSelectItemAt(image: selectedDatum.image ?? "")
               
    }
    
    
}
extension SectionSecondViewCell{
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
           data = result as! [Music]
          collectionSecondCell.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
    }
}
