import UIKit

class BrowseCell: UITableViewCell {
    var data: [Datum] = []
    var apiModel = ColdplayApiModel()
    @IBOutlet weak var collectionBrowse: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromAPI()
    }
}
extension BrowseCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionBrowse.delegate = self
        collectionBrowse.dataSource = self
        collectionBrowse.registerCellWithNib(BrowseCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rowCount = (data.count + 1) / 2
        return rowCount * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionBrowse.dequeueReusableCell(withReuseIdentifier: "BrowseCollection", for: indexPath) as! BrowseCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        cell.labelBrowse?.text = datum.artist?.name?.rawValue
        if let imageUrl = datum.album?.cover {
            let url = URL(string: imageUrl)
            cell.imgBrowse?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgBrowse?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    
    
}
extension BrowseCell{
    func fetchDataFromAPI(){
        let musicViewModel = ColdplayApiModel()
        musicViewModel.fetchData { [weak self] data in
            if let data = data {
                self?.data = data
                DispatchQueue.main.async {
                    self?.collectionBrowse.reloadData()
                }
            }
        }
    }
}
