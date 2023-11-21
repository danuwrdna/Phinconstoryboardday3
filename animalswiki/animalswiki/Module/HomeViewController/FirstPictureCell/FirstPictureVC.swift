import UIKit
import Kingfisher
class FirstPictureVC: UITableViewCell {
    
    @IBOutlet weak var firstpcCollection: UICollectionView!
    var listCat: [CatModel]?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
    }
}
extension FirstPictureVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = firstpcCollection.dequeueReusableCell(withReuseIdentifier: "FirstPcCollection", for: indexPath) as! FirstPcCollection
        cell.imageViewFirst?.image = UIImage(named: "singa1")
        return cell
    }
    
    
    func setupCollection(){
        firstpcCollection.delegate = self
        firstpcCollection.dataSource = self
        firstpcCollection.registerCellWithNib(FirstPcCollection.self)
    }
}
