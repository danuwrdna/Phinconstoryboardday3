import UIKit
import CHTCollectionViewWaterfallLayout

class ListContentVC: UIViewController {
    
    @IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var models = [ListContentModel]()
    var images: [String] = ["profile1","profile2","profile3", "profile4", "profile5","profile6"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigateImage()
        navigationItem.hidesBackButton = true
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupNavigateImage(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backTapped))
        imageBack.isUserInteractionEnabled = true
        imageBack.addGestureRecognizer(tapGesture)
    }
    
    @objc func backTapped() {
        print("Back button tapped!")
        navigationController?.popViewController(animated: true)
    }
    
    func setup(){
        models = ListContentModel.sampleData()

        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "PinterestViewCell", bundle: nil), forCellWithReuseIdentifier: "PinterestViewCell")
    }
}

extension ListContentVC: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PinterestViewCell", for: indexPath) as! PinterestViewCell
        cell.imageView?.image = UIImage(named: models[indexPath.row].imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/2, height: models[indexPath.row].height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        let detailVC = DetailProfileVC()
        let collectionDetailVC = DpViewCell()
      
        detailVC.image = UIImage(named: images[indexPath.row])
        collectionDetailVC.image2 = UIImage(named: images[indexPath.row])

            navigationController?.pushViewController(detailVC, animated: true)
            tabBarController?.tabBar.isHidden = true
            navigationItem.hidesBackButton = true
    }
}
