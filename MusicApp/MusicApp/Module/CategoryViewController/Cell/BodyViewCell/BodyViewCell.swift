import UIKit

class BodyViewCell: UITableViewCell {
    var data: [Datum] = []
    var apiModel = ColdplayApiModel()
    @IBOutlet weak var bodyCollectionCell: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromAPI()
    }
}
extension BodyViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        bodyCollectionCell.delegate = self
        bodyCollectionCell.dataSource = self
        bodyCollectionCell.registerCellWithNib(BodyCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bodyCollectionCell.dequeueReusableCell(withReuseIdentifier: "BodyCollection", for: indexPath) as! BodyCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        cell.labelBodyCollection?.text = datum.artist?.name?.rawValue
        if let imageUrl = datum.album?.cover {
            let url = URL(string: imageUrl)
            cell.imgBodyCollection?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgBodyCollection?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    
    
}
extension BodyViewCell{
    func fetchDataFromAPI(){
        let musicViewModel = ColdplayApiModel()
        musicViewModel.fetchData { [weak self] data in
            if let data = data {
                self?.data = data
                DispatchQueue.main.async {
                    self?.bodyCollectionCell.reloadData()
                }
            }
        }
    }
}
