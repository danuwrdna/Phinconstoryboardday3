import UIKit
import CHTCollectionViewWaterfallLayout

struct Model{
    let imageName: String
    let height: CGFloat
}

class ListContentVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var models = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationItem.hidesBackButton = true
    }
    
    
    func setup(){
        let images = Array(1...6).map{"profile\($0)"}
//        models = images.compactMap{
//            return Model.init(imageName: $0,
//                              height: CGFloat.random(in: 200...300))
//        }
        
        models = images.enumerated().compactMap { (index, value) in
            // Your condition or transformation logic here
            if index == 0{
                return Model.init(imageName: value,
                                  height: 272)
            } else if index % 2 != 0 {
                return Model.init(imageName: value,
                                 height: 200)
            } else {
                return Model.init(imageName: value,
                                 height: 200)
            }
        }

        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "PinterestViewCell", bundle: nil), forCellWithReuseIdentifier: "PinterestViewCell")
    }
   
}
extension ListContentVC: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PinterestViewCell", for: indexPath) as! PinterestViewCell
        let data = [indexPath.row]
        cell.imageView?.image = UIImage(named: models[indexPath.row].imageName)
  
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/2, height: models[indexPath.row].height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           // Navigasi ke layar tujuan setelah item diketuk
           let bt = DetailProfileVC() // Gantilah dengan nama ViewController tujuan Anda
           navigationController?.pushViewController(bt, animated: true)
        tabBarController?.tabBar.isHidden = true
        navigationItem.hidesBackButton = true
       }

}


    
    
