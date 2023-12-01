import UIKit

class FirstCellImageVC: UITableViewCell {
    var dogViewModel = DogViewModel()
   
    @IBOutlet weak var colFirstCellImage: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        callApi()
    }
    func callApi(){
        dogViewModel.onDataUpdate = { [weak self] in
            self?.colFirstCellImage.reloadData()
        }
        
        dogViewModel.fetchData()
        
    }
}
extension FirstCellImageVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        colFirstCellImage.delegate = self
        colFirstCellImage.dataSource = self
        colFirstCellImage.registerCellWithNib(ColFirstCellImage.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogViewModel.numberOfItems > 0 ? .max : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colFirstCellImage.dequeueReusableCell(withReuseIdentifier: "ColFirstCellImage", for: indexPath) as! ColFirstCellImage
        guard dogViewModel.numberOfItems > 0 else {
            return cell
        }
        let dogIndex = indexPath.row % dogViewModel.numberOfItems
        if let dog = dogViewModel.getDogItem(at: dogIndex) {
            let url = URL(string: dog)
            cell.imageColF.kf.setImage(with: url)
        }
        return cell
    }
    
    
}
