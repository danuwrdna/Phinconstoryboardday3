import UIKit
struct Isi{
    let imageName: String
}
class ListViewController: UIViewController {
    @IBOutlet weak var koleksiView: UICollectionView!
    var isi = [Isi]()
    override func viewDidLoad() {
        super.viewDidLoad()
        koleksiView.dataSource = self
        koleksiView.delegate = self
        koleksiView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        configure()
    }
    func configure(){
        isi.append(Isi(
                          imageName: "350x350"
                          ))
        isi.append(Isi(
                          imageName: "c734b124310ef95e2f8fcd3a17f1d1ed.1000x1000x1"
                          ))
        isi.append(Isi(
                          imageName: "R-731019-1686050660-1456"
                          ))
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let data = isi[indexPath.row]
        cell.imageView?.image = UIImage(named: data.imageName )
        return cell
    }
}
