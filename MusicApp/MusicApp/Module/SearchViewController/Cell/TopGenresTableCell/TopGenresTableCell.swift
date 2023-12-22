import UIKit
import CoreData
protocol TopTableCell {
    func didSelectItemAt(subTitle: String)
}
class TopGenresTableCell: UITableViewCell {
    private var coreDataArray: [Music] = [] {
        didSet {
            topGenreCollectionCell.reloadData()
        }
    }
    var delegate: TopTableCell?
    @IBOutlet weak var topGenreCollectionCell: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
    }    
}
extension TopGenresTableCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func delegateCollection(){
        topGenreCollectionCell.delegate = self
        topGenreCollectionCell.dataSource = self
        topGenreCollectionCell.registerCellWithNib(TopGenresCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topGenreCollectionCell.dequeueReusableCell(withReuseIdentifier: "TopGenresCollection", for: indexPath) as! TopGenresCollection
        cell.modelImgViewModel = ModelImgViewModel()
        let datum = coreDataArray[indexPath.item]
        cell.labelTextTopGenre?.text = datum.subtitle
        if let imageUrl = datum.image {
            let url = URL(string: imageUrl)
            cell.imgTopGenreCollection?.kf.setImage(with: url)
        } else {
            // Handle case when album cover URL is not available
            cell.imgTopGenreCollection?.image = UIImage(named: "placeholderImage") // You can use a placeholder image
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDatum = coreDataArray[indexPath.item]
        if let subTitle = selectedDatum.subtitle{
            delegate?.didSelectItemAt(subTitle: subTitle)
        }
    }
    
    
}
extension TopGenresTableCell{
    internal func passData(data: [Music]) {
        self.coreDataArray = data
    }
}
