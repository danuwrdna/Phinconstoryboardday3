import UIKit

class ThirdCellImageVC: UITableViewCell {
    var dogViewModel = DogViewModel()
    @IBOutlet weak var colThirdCellImage: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegateCollection()
        callApi()
        colThirdCellImage.collectionViewLayout = Self.createLayout()
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
        return dogViewModel.numberOfItems
        
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
    static func createLayout() -> UICollectionViewCompositionalLayout{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/4),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5, leading: 5, bottom: 5, trailing: 5)
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
                widthDimension: .fractionalWidth(2/4),
                heightDimension: .fractionalHeight(2)),
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



