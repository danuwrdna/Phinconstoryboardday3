import UIKit
protocol ThirdPictureDelegate: AnyObject {
    func didSelectCell()
}
class ThirdPictureCell: UITableViewCell {
    @IBOutlet weak var collectionThird: UICollectionView!
    @IBOutlet weak var adamLabel: UILabel!
    var parentViewController: UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
        setupLayout()
        setupLabel()
    }
    func setupLabel(){
    }
    @objc func adamLabelTapped() {
    }
}
extension ThirdPictureCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func setupCollection(){
        collectionThird.delegate = self
        collectionThird.dataSource = self
        collectionThird.registerCellWithNib(ThirdPcCollection.self)
    }
    func setupLayout(){
        let layout = UICollectionViewFlowLayout()
        let cellWidth = 170
        let cellHeight = 180
        
        layout.minimumInteritemSpacing = 0// Atur sesuai kebutuhan Anda
        layout.minimumLineSpacing = 0// Atur sesuai kebutuhan Anda
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionThird.collectionViewLayout = layout
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionThird.dequeueReusableCell(withReuseIdentifier: "ThirdPcCollection", for: indexPath) as! ThirdPcCollection
        cell.imageThird!.image = UIImage(named: "profile\(indexPath.row + 1).imageset")
        return cell
    }
    
    
}
