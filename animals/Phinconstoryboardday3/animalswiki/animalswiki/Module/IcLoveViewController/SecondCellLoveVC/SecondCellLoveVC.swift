import UIKit
import Kingfisher
class SecondCellLoveVC: UITableViewCell {
   
    @IBOutlet weak var collectionLoveVcSecond: UICollectionView!
   let viewModel = HomeViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        delegateCollectionLoveVcSecond()
        collectionLoveVcSecond.collectionViewLayout = Self.createLayout()
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
    static func createLayout() -> UICollectionViewCompositionalLayout{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2, leading: 2, bottom: 2, trailing: 2)
        let verticalStackItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2),
                heightDimension: .fractionalHeight(0.5)
                
            )
        )
        verticalStackItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2, leading: 2, bottom: 2, trailing: 2)
        let verticalStackGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5/3),
            heightDimension: .fractionalHeight(1)),
        subitem: verticalStackItem,
        count: 2
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(3/5)
            ),
            subitems: [
                item,
                verticalStackGroup
            ]
        )
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}


