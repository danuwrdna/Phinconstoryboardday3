import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        showNaviItem()
    }
    override func viewWillAppear( _ animated: Bool) {
            super.viewWillAppear(animated)
            // Hide the navigation bar
            showNaviItem()
        setupCollection()
        }
    func setupCollection(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
    }

    override func viewWillDisappear( _ animated: Bool) {
            super.viewWillDisappear(animated)
            // Re-enable the navigation bar when leaving this view
            showNaviItem()
        }

        func showNaviItem(){
            navigationController?.navigationBar.isHidden = true
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
}
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let data = [indexPath.row]
        cell.viewImage?.image = UIImage(named: "unsplash_1-QfoBxAvZE")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // Mengatur ukuran setiap item di sini
            return CGSize(width: 300, height: 100)
        }
    
}
