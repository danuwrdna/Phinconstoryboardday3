import UIKit

protocol SectionSecondViewCellDelegate {
    func didSelectItemAt(image: String)
}

class SectionSecondViewCell: UITableViewCell {
    @IBOutlet weak var collectionSecondCell: UICollectionView!
    var data: [Datum] = []
    var apiModel = ColdplayApiModel()
    var didSelectItem: ((Datum) -> Void)?
    var delegate: SectionSecondViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        fetchDataFromAPI()
        delegateCollection()
    }
}
extension SectionSecondViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionSecondCell.delegate = self
        collectionSecondCell.dataSource = self
        collectionSecondCell.registerCellWithNib(SectionSecondViewCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionSecondCell.dequeueReusableCell(withReuseIdentifier: "SectionSecondViewCollection", for: indexPath) as! SectionSecondViewCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        didSelectItem?(datum)
        cell.textLabelSecondCollection?.text = datum.artist?.name?.rawValue
        if let imageUrl = datum.album?.cover {
            let url = URL(string: imageUrl)
            cell.imgViewSecondCollection?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgViewSecondCollection?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDatum = data[indexPath.item]
        delegate?.didSelectItemAt(image: selectedDatum.album?.cover ?? "")
               
    }
    
    
}
extension SectionSecondViewCell{
    func fetchDataFromAPI(){
        let musicViewModel = ColdplayApiModel()
        musicViewModel.fetchData { [weak self] data in
            if let data = data {
                self?.data = data
                DispatchQueue.main.async {
                    self?.collectionSecondCell.reloadData()
                }
            }
        }
    }
}
