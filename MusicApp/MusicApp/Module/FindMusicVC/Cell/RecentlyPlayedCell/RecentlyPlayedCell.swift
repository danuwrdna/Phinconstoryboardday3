
import UIKit

class RecentlyPlayedCell: UITableViewCell {
    var data: [Datum] = []
    var apiModel = ColdplayApiModel()
    @IBOutlet weak var collectionRecentlyPlayed: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromAPI()
    }
}
extension RecentlyPlayedCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionRecentlyPlayed.delegate = self
        collectionRecentlyPlayed.dataSource = self
        collectionRecentlyPlayed.registerCellWithNib(RecentlyPlayedCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionRecentlyPlayed.dequeueReusableCell(withReuseIdentifier: "RecentlyPlayedCollection", for: indexPath) as! RecentlyPlayedCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        cell.labelRecentlyPlayed?.text = datum.artist?.name?.rawValue
        if let imageUrl = datum.album?.cover {
            let url = URL(string: imageUrl)
            cell.imgRecentlyPlayed?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgRecentlyPlayed?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    
    
}
extension RecentlyPlayedCell{
    func fetchDataFromAPI(){
        let musicViewModel = ColdplayApiModel()
        musicViewModel.fetchData { [weak self] data in
            if let data = data {
                self?.data = data
                DispatchQueue.main.async {
                    self?.collectionRecentlyPlayed.reloadData()
                }
            }
        }
    }
}
