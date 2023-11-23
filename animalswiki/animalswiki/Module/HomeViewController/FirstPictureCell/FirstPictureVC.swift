import UIKit
import Kingfisher
class FirstPictureVC: UITableViewCell {
    @IBAction func refreshButton(_ sender: Any) {
        refresh()
    }
    
    @IBOutlet weak var firstpcCollection: UICollectionView!
    let viewModel = HomeViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewModel()
        setupCollection()
    }
    func setupViewModel() {
           viewModel.onDataUpdate = { [weak self] in
               self?.firstpcCollection.reloadData()
           }
           viewModel.fetchData()
       }
    func refresh(){
        viewModel.fetchData()
    }
}
extension FirstPictureVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func setupCollection(){
        firstpcCollection.delegate = self
        firstpcCollection.dataSource = self
        firstpcCollection.registerCellWithNib(FirstPcCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = firstpcCollection.dequeueReusableCell(withReuseIdentifier: "FirstPcCollection", for: indexPath) as! FirstPcCollection
        if let cat = viewModel.getCatItem(at: indexPath.row) {
                    let url = URL(string: cat.url)
                    cell.imageViewFirst.kf.setImage(with: url)
        }
        return cell
    }
}
