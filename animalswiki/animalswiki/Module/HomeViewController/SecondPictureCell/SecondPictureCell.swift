
import UIKit

class SecondPictureCell: UITableViewCell {
    @IBOutlet weak var secondCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
       setupCollection()
    }
    
}
extension SecondPictureCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func setupCollection(){
        secondCollection.dataSource = self
        secondCollection.delegate = self
        secondCollection.registerCellWithNib(SecondPcCollection.self)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = secondCollection.dequeueReusableCell(withReuseIdentifier: "SecondPcCollection", for: indexPath) as! SecondPcCollection
        cell.imageSecond!.image = UIImage(named: "singa2")
        cell.imageSecond.frame.size = CGSize(width: cell.bounds.width / 6, height: cell.bounds.height / 6)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Mengembalikan CGSize yang menentukan tinggi dan lebar item di indexPath tertentu
           return CGSize(width: 00, height: 0)
       }
}
