import UIKit

class SectionThirdViewCell: UITableViewCell {
    var data: [Datum] = []
    var apiModel = ColdplayApiModel()
    @IBOutlet weak var collectionSectionThird: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        fetchDataFromAPI()
       
    }
}
extension SectionThirdViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionSectionThird.delegate = self
        collectionSectionThird.dataSource = self
        collectionSectionThird.registerCellWithNib(SectionThirdViewCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionSectionThird.dequeueReusableCell(withReuseIdentifier: "SectionThirdViewCollection", for: indexPath) as! SectionThirdViewCollection// Replace YourCollectionViewCell with the actual name of your cell class
        let datum = data[indexPath.item]
        cell.textLabelCollectionThird?.text = datum.artist?.name?.rawValue
        if let imageUrl = datum.album?.cover {
            let url = URL(string: imageUrl)
            cell.imgCollectionThird?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgCollectionThird?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    
    
}
extension SectionThirdViewCell{
    func fetchDataFromAPI(){
        let musicViewModel = ColdplayApiModel()
        musicViewModel.fetchData { [weak self] data in
            if let data = data {
                self?.data = data
                DispatchQueue.main.async {
                    self?.collectionSectionThird.reloadData()
                }
            }
        }
    }
}
