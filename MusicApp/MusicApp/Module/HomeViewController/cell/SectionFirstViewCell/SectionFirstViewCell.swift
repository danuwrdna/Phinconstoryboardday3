import UIKit
import CoreData
class SectionFirstViewCell: UITableViewCell {
    @IBOutlet weak var sectionFirstViewCollection: UICollectionView!
    var coreDataArray: [Music] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromCoreData()
    }
}
extension SectionFirstViewCell{
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
            coreDataArray = result as! [Music]
            sectionFirstViewCollection.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
    }
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
        let cell = sectionFirstViewCollection.dequeueReusableCell(withReuseIdentifier: "SectionFirstViewCollection", for: indexPath) as! SectionFirstViewCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = coreDataArray[indexPath.item]
        cell.textFirstLabel?.text = datum.subtitle
        if let imageUrl = datum.image {
            let url = URL(string: imageUrl)
            cell.imgViewFirstCollection?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgViewFirstCollection?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
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
