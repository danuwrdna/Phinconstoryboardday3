import UIKit

class SectionFirstViewCell: UITableViewCell {
    @IBOutlet weak var sectionFirstViewCollection: UICollectionView!
    var data: [Datum] = []
    var apiModel = ColdplayApiModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromAPI()
        
    }
    
}
extension SectionFirstViewCell{
    func fetchDataFromAPI(){
        let musicViewModel = ColdplayApiModel()
        musicViewModel.fetchData { [weak self] data in
            if let data = data {
                self?.data = data
                DispatchQueue.main.async {
                    self?.sectionFirstViewCollection.reloadData()
                }
            }
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
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sectionFirstViewCollection.dequeueReusableCell(withReuseIdentifier: "SectionFirstViewCollection", for: indexPath) as! SectionFirstViewCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        cell.textFirstLabel?.text = datum.artist?.name?.rawValue
        if let imageUrl = datum.album?.cover {
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
