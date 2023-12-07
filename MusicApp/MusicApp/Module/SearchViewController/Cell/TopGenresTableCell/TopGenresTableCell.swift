import UIKit

class TopGenresTableCell: UITableViewCell {
    var data: [Datum] = []
    var apiModel = ColdplayApiModel()
    @IBOutlet weak var topGenreCollectionCell: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromAPI()
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
        let cell = topGenreCollectionCell.dequeueReusableCell(withReuseIdentifier: "TopGenresCollection", for: indexPath) as! TopGenresCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        cell.labelTextTopGenre?.text = datum.artist?.name?.rawValue
        if let imageUrl = datum.album?.cover {
            let url = URL(string: imageUrl)
            cell.imgTopGenreCollection?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgTopGenreCollection?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    
    
}
extension TopGenresTableCell{
    func fetchDataFromAPI(){
        let musicViewModel = ColdplayApiModel()
        musicViewModel.fetchData { [weak self] data in
            if let data = data {
                self?.data = data
                DispatchQueue.main.async {
                    self?.topGenreCollectionCell.reloadData()
                }
            }
        }
    }
}
