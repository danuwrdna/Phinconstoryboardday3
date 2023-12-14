
import UIKit

class ExploreCell: UITableViewCell {
    var data: [Datum] = []
    var apiModel = ColdplayApiModel()
    @IBOutlet weak var collectionExplore: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromAPI()
    }
}
extension ExploreCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionExplore.delegate = self
        collectionExplore.dataSource = self
        collectionExplore.registerCellWithNib(ExploreCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionExplore.dequeueReusableCell(withReuseIdentifier: "ExploreCollection", for: indexPath) as! ExploreCollection// Replace YourCollectionViewCell with the actual name of your cell class
        
        let datum = data[indexPath.item]
        cell.labelTitleExplore?.text = datum.artist?.name?.rawValue
        cell.labelSubTitleExplore.text = datum.title
        if let imageUrl = datum.album?.cover {
            let url = URL(string: imageUrl)
            cell.imgExplore?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgExplore?.image = UIImage(named: "placeholderImage")
            // You can use a placeholder image
        }
        
        return cell
    }
    
}
extension ExploreCell{
    func fetchDataFromAPI(){
        let musicViewModel = ColdplayApiModel()
        musicViewModel.fetchData { [weak self] data in
            if let data = data {
                self?.data = data
                DispatchQueue.main.async {
                    self?.collectionExplore.reloadData()
                }
            }
        }
    }
}
