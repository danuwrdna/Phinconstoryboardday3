import UIKit
import Kingfisher
class FirstCellLoveVC: UITableViewCell {
    var dogViewModel = DogViewModel()

    @IBOutlet weak var collectionLoveVcFirst: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollectionLoveVcFirst()
        callApi()
    }
    func callApi(){
        dogViewModel.onDataUpdate = { [weak self] in
            self?.collectionLoveVcFirst.reloadData()
        }
        
        dogViewModel.fetchData()
        
    }
}
extension FirstCellLoveVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollectionLoveVcFirst(){
        collectionLoveVcFirst.delegate = self
        collectionLoveVcFirst.dataSource = self
        collectionLoveVcFirst.registerCellWithNib(CollectionLoveFirst.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogViewModel.numberOfItems > 0 ? .max : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionLoveVcFirst.dequeueReusableCell(withReuseIdentifier: "CollectionLoveFirst", for: indexPath) as! CollectionLoveFirst
        guard dogViewModel.numberOfItems > 0 else {
            return cell
        }
        let dogIndex = indexPath.row % dogViewModel.numberOfItems
        if let dog = dogViewModel.getDogItem(at: dogIndex) {
            let url = URL(string: dog)
            cell.imageCLF.kf.setImage(with: url)
        }
        return cell
        
    }
}
