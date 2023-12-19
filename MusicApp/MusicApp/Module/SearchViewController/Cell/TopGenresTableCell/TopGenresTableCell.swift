import UIKit
import CoreData
protocol TopTableCell {
    func didSelectItemAt(text: String)
}
class TopGenresTableCell: UITableViewCell {
    var data: [Music] = []
    var delegate: TopTableCell?
    @IBOutlet weak var topGenreCollectionCell: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromCoreData()
    }    
}
extension TopGenresTableCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func delegateCollection(){
        topGenreCollectionCell.delegate = self
        topGenreCollectionCell.dataSource = self
        topGenreCollectionCell.registerCellWithNib(TopGenresCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topGenreCollectionCell.dequeueReusableCell(withReuseIdentifier: "TopGenresCollection", for: indexPath) as! TopGenresCollection
        cell.modelImgViewModel = ModelImgViewModel()
        let datum = data[indexPath.item]
        cell.labelTextTopGenre?.text = datum.subtitle
        if let imageUrl = datum.image {
            let url = URL(string: imageUrl)
            cell.imgTopGenreCollection?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgTopGenreCollection?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDatum = data[indexPath.item]
        delegate?.didSelectItemAt(text: selectedDatum.subtitle ?? "")
    }
    
    
}
extension TopGenresTableCell{
    func fetchDataFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do {
            let result = try context.fetch(fetchRequest)
           data = result as! [Music]
          topGenreCollectionCell.reloadData()
        } catch {
            fatalError("Gagal mengambil data dari Core Data: \(error)")
        }
    }
}
