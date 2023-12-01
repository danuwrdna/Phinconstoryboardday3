

import UIKit
import Kingfisher
class SecondCellImageVC: UITableViewCell {
    var dogViewModel = DogViewModel()
    @IBOutlet weak var colSecondCellImage: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        callApi()
    }
    func callApi(){
        dogViewModel.onDataUpdate = { [weak self] in
            self?.colSecondCellImage.reloadData()
        }
        
        dogViewModel.fetchData()
        
    }
}
extension SecondCellImageVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        colSecondCellImage.delegate = self
        colSecondCellImage.dataSource = self
        colSecondCellImage.registerCellWithNib(ColSecondCellImage.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colSecondCellImage.dequeueReusableCell(withReuseIdentifier: "ColSecondCellImage", for: indexPath) as! ColSecondCellImage
        let dogIndex = indexPath.row
        if let dog = dogViewModel.getDogItem(at: dogIndex) {
            let url = URL(string: dog)
            cell.imageColS.kf.setImage(with: url)
        }
        return cell
    }
    
    
}
