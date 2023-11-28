import UIKit

class FourCellLoveVC: UITableViewCell {
    var dogViewModel = DogViewModel()
    @IBOutlet weak var collectionLoveFour: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        callApi()
    }
    func callApi(){
        dogViewModel.onDataUpdate = { [weak self] in
            self?.collectionLoveFour.reloadData()
        }
        
        dogViewModel.fetchData()
        
    }
}
extension FourCellLoveVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        collectionLoveFour.delegate = self
        collectionLoveFour.dataSource = self
        collectionLoveFour.registerCellWithNib(CollectionLoveFour.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionLoveFour.dequeueReusableCell(withReuseIdentifier: "CollectionLoveFour", for: indexPath) as! CollectionLoveFour
        let dogIndex = indexPath.row
        if let dog = dogViewModel.getDogItem(at: dogIndex) {
            let url = URL(string: dog)
            cell.imageFR.kf.setImage(with: url)
        }
        return cell
    }
    
    
}
