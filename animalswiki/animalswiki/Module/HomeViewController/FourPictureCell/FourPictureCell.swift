import UIKit

class FourPictureCell: UITableViewCell {

    @IBOutlet weak var collectionFour: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
       setupCollection()
        setupLayout()
    }
}
extension FourPictureCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func setupLayout(){
        let layout = UICollectionViewFlowLayout()
        let cellWidth = 160
        let cellHeight = 170
        
        layout.minimumInteritemSpacing = 0// Atur sesuai kebutuhan Anda
        layout.minimumLineSpacing = 0// Atur sesuai kebutuhan Anda
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionFour.collectionViewLayout = layout
    }
    func setupCollection(){
        collectionFour.delegate = self
        collectionFour.dataSource = self
        collectionFour.registerCellWithNib(FourPcCell.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionFour.dequeueReusableCell(withReuseIdentifier: "FourPcCell", for: indexPath) as! FourPcCell
        cell.imageFour!.image = UIImage(named: "home\(indexPath.row + 1).imageset")
        return cell
    }
    
    
}
