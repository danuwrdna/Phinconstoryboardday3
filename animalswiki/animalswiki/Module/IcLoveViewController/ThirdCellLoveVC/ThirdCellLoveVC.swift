import UIKit

class ThirdCellLoveVC: UITableViewCell{
    @IBOutlet weak var collectionLoveVcThird: UICollectionView!
    var dogViewModel = DogViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollectionLoveVcThird()
        callApi()
        
    }
    func callApi(){
        dogViewModel.onDataUpdate = { [weak self] in
            self?.collectionLoveVcThird.reloadData()
        }
        
        dogViewModel.fetchData()
        
    }
}
extension ThirdCellLoveVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollectionLoveVcThird(){
        collectionLoveVcThird.delegate = self
        collectionLoveVcThird.dataSource = self
        collectionLoveVcThird.registerCellWithNib(CollectionLoveThird.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogViewModel.numberOfItems > 0 ? .max : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionLoveVcThird.dequeueReusableCell(withReuseIdentifier: "CollectionLoveThird", for: indexPath) as! CollectionLoveThird
        guard dogViewModel.numberOfItems > 0 else {
            return cell
        }
        let dogIndex = indexPath.row % dogViewModel.numberOfItems
        if let dog = dogViewModel.getDogItem(at: dogIndex) {
            let url = URL(string: dog)
            cell.imageCLT.kf.setImage(with: url)
        }
        return cell
        
    }
}


