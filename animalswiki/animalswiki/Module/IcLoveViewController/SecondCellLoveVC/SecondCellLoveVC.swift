import UIKit
import Kingfisher
class SecondCellLoveVC: UITableViewCell {
   
    @IBOutlet weak var collectionLoveVcSecond: UICollectionView!
   let viewModel = HomeViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        delegateCollectionLoveVcSecond()
    }
    func setup() {
        viewModel.onDataUpdate = { [weak self] in
            self?.collectionLoveVcSecond.reloadData()
        }
        viewModel.fetchData()
    }
}
extension SecondCellLoveVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollectionLoveVcSecond(){
        collectionLoveVcSecond.delegate = self
        collectionLoveVcSecond.dataSource = self
        collectionLoveVcSecond.registerCellWithNib(CollectionLoveSecond.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems > 0 ? .max : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionLoveVcSecond.dequeueReusableCell(withReuseIdentifier: "CollectionLoveSecond", for: indexPath) as! CollectionLoveSecond
        guard viewModel.numberOfItems > 0 else {
            return cell
        }
        let catIndex = indexPath.row % viewModel.numberOfItems
        if let cat = viewModel.getCatItem(at: catIndex) {
            let url = URL(string: cat.url)
            cell.imageCLS.kf.setImage(with: url)
        }
        return cell
    }
}


