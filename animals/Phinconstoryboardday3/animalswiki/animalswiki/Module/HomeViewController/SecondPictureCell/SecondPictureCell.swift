
import UIKit

class SecondPictureCell: UITableViewCell {
    var dogViewModel = DogViewModel()
    @IBOutlet weak var secondCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
        callApi()
    }
    func callApi(){
        dogViewModel.onDataUpdate = { [weak self] in
            self?.secondCollection.reloadData()
        }
        
        dogViewModel.fetchData()
        
    }
}
extension SecondPictureCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func setupCollection(){
        secondCollection.dataSource = self
        secondCollection.delegate = self
        secondCollection.registerCellWithNib(SecondPcCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogViewModel.numberOfItems > 0 ? .max : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = secondCollection.dequeueReusableCell(withReuseIdentifier: "SecondPcCollection", for: indexPath) as! SecondPcCollection
        guard dogViewModel.numberOfItems > 0 else {
            return cell
        }
        let dogIndex = indexPath.row % dogViewModel.numberOfItems
        if let dog = dogViewModel.getDogItem(at: dogIndex) {
            let url = URL(string: dog)
            cell.imageSecond.kf.setImage(with: url)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Mengembalikan CGSize yang menentukan tinggi dan lebar item di indexPath tertentu
        return CGSize(width: 00, height: 0)
    }
}
