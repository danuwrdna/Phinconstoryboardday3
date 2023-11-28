import UIKit

class ThirdCellLoveVC: UITableViewCell{
    @IBOutlet weak var collectionLoveVcThird: UICollectionView!
    var dogViewModel = DogViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollectionLoveVcThird()
        callApi()
        collectionLoveVcThird.collectionViewLayout = Self.createLayout()
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


