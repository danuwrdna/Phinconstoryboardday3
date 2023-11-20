import UIKit

class FourPictureCell: UITableViewCell {

    @IBOutlet weak var collectionFour: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
       setupCollection()
    }
}
extension FourPictureCell: UICollectionViewDelegate, UICollectionViewDataSource{
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
