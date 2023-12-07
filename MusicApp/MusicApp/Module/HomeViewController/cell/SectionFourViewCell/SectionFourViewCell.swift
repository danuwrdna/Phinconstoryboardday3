import UIKit

class SectionFourViewCell: UITableViewCell {
    var data: [Datum] = []
    var apiModel = ColdplayApiModel()
    @IBOutlet weak var collectionFourCell: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       delegateCollection()
        fetchDataFromAPI()
    }
}
extension SectionFourViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionFourCell.delegate = self
        collectionFourCell.dataSource = self
       collectionFourCell.registerCellWithNib(SectionFourViewCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionFourCell.dequeueReusableCell(withReuseIdentifier: "SectionFourViewCollection", for: indexPath) as! SectionFourViewCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        cell.labelTextCollectionFour.text = datum.artist?.name?.rawValue
        if let imageUrl = datum.album?.cover {
            let url = URL(string: imageUrl)
            cell.imgCollectionFour?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgCollectionFour?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    }
extension SectionFourViewCell{
    func fetchDataFromAPI(){
        let musicViewModel = ColdplayApiModel()
        musicViewModel.fetchData { [weak self] data in
            if let data = data {
                self?.data = data
                DispatchQueue.main.async {
                    self?.collectionFourCell.reloadData()
                }
            }
        }
    }
}
