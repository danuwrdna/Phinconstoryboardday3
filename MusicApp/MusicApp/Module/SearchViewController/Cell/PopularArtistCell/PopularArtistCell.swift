import UIKit

class PopularArtistCell: UITableViewCell {
    var data: [Datum] = []
    var apiModel = ColdplayApiModel()
    @IBOutlet weak var collectionPopularArtist: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromAPI()
    }    
}
extension PopularArtistCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionPopularArtist.delegate = self
        collectionPopularArtist.dataSource = self
        collectionPopularArtist.registerCellWithNib(PopularArtistCollection.self)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionPopularArtist.dequeueReusableCell(withReuseIdentifier: "PopularArtistCollection", for: indexPath) as! PopularArtistCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        cell.labelPopularArtist?.text = datum.artist?.name?.rawValue
        if let imageUrl = datum.album?.cover {
            let url = URL(string: imageUrl)
            cell.imgPopularArtist?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgPopularArtist?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    
    
}
extension PopularArtistCell{
    func fetchDataFromAPI(){
        let musicViewModel = ColdplayApiModel()
        musicViewModel.fetchData { [weak self] data in
            if let data = data {
                self?.data = data
                DispatchQueue.main.async {
                    self?.collectionPopularArtist.reloadData()
                }
            }
        }
    }
}
