import UIKit
import Kingfisher
class FirstCellLoveVC: UITableViewCell {
    var dogViewModel = DogViewModel()
    
    @IBOutlet weak var collectionLoveVcFirst: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollectionLoveVcFirst()
        callApi()
        collectionLoveVcFirst.collectionViewLayout = Self.createLayout()
        
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
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(
            identifier: nil, previewProvider: nil) { _ in
                let open = UIAction(title: "open",
                                    image: UIImage(systemName: "link"),
                                    identifier: nil,
                                    discoverabilityTitle: nil,
                                    state: .off){ _ in
                    print("tapped")
                }
                return UIMenu(title: "",
                              image: nil,
                              identifier: nil,
                              options: UIMenu.Options.displayInline,
                              children: [open])
            }
        return config
    }
    static func createLayout() -> UICollectionViewCompositionalLayout{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2, leading: 5, bottom: 2, trailing: 5)
        let verticalStackItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2),
                heightDimension: .fractionalHeight(0.5)
                
            )
        )
        verticalStackItem.contentInsets = NSDirectionalEdgeInsets(
            top: 5, leading: 5, bottom: 5, trailing: 5)
        let verticalStackGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.4/3),
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
