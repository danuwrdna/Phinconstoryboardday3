import UIKit

class ThirdCellImageVC: UITableViewCell {
    var dogViewModel = DogViewModel()
    @IBOutlet weak var colThirdCellImage: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        callApi()
    }
    func callApi(){
        dogViewModel.onDataUpdate = { [weak self] in
            self?.colThirdCellImage.reloadData()
        }
        
        dogViewModel.fetchData()
        
    }
}
extension ThirdCellImageVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func delegateCollection(){
        colThirdCellImage.delegate = self
        colThirdCellImage.dataSource = self
        colThirdCellImage.registerCellWithNib(ColThirdCellImage.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colThirdCellImage.dequeueReusableCell(withReuseIdentifier: "ColThirdCellImage", for: indexPath) as! ColThirdCellImage
        let dogIndex = indexPath.row
        if let dog = dogViewModel.getDogItem(at: dogIndex) {
            let url = URL(string: dog)
            cell.imageCLT.kf.setImage(with: url)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> Int {
        switch indexPath.section{
        case 0:
            return 100
        case 1:
            return 200
        default:
            return 100
        }
    }
}



