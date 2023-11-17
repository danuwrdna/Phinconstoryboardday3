import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionAc: UICollectionView!
    @IBOutlet weak var collectionFP: UICollectionView!
    @IBOutlet weak var collectionProduction: UICollectionView!
    @IBOutlet weak var adamLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        showNaviItem()
        setupCollection()
        setupLabelGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar
        showNaviItem()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Re-enable the navigation bar when leaving this view
        showNaviItem()
    }

    func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")

        collectionAc.delegate = self
        collectionAc.dataSource = self
        collectionAc.register(UINib(nibName: "AnimalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AnimalCollectionViewCell")

        collectionFP.delegate = self
        collectionFP.dataSource = self
        collectionFP.register(UINib(nibName: "CollectionFPViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionFPViewCell")

        collectionProduction.delegate = self
        collectionProduction.dataSource = self
        collectionProduction.register(UINib(nibName: "CollectionProductionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionProductionViewCell")
    }

    func showNaviItem() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func setupLabelGesture() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(adamLabelTapped))
            adamLabel.isUserInteractionEnabled = true
            adamLabel.addGestureRecognizer(tapGesture)
        }

        @objc func adamLabelTapped() {
            let bt = ListContentVC()
            navigationController?.pushViewController(bt, animated: true)
        }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        var imageName = ""

        switch collectionView {
        case self.collectionView:
            guard let specificCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
                fatalError("Failed to dequeue CollectionViewCell")
            }
            cell = specificCell
            imageName = "singa1"
        case collectionAc:
            guard let specificCell = collectionAc.dequeueReusableCell(withReuseIdentifier: "AnimalCollectionViewCell", for: indexPath) as? AnimalCollectionViewCell else {
                fatalError("Failed to dequeue AnimalCollectionViewCell")
            }
            cell = specificCell
            imageName = "singa2"
        case collectionFP:
            guard let specificCell = collectionFP.dequeueReusableCell(withReuseIdentifier: "CollectionFPViewCell", for: indexPath) as? CollectionFPViewCell else {
                fatalError("Failed to dequeue CollectionFPViewCell")
            }
            cell = specificCell
            imageName = "home\(indexPath.row + 1)"
        case collectionProduction:
            guard let specificCell = collectionProduction.dequeueReusableCell(withReuseIdentifier: "CollectionProductionViewCell", for: indexPath) as? CollectionProductionViewCell else {
                fatalError("Failed to dequeue CollectionProductionViewCell")
            }
            cell = specificCell
            imageName = "profile\(indexPath.row + 1)"
        default:
            fatalError("Unexpected collection view")
        }

        if let imageView = (cell as? CollectionViewCell)?.viewImage {
            imageView.image = UIImage(named: imageName)
        } else if let imageView = (cell as? AnimalCollectionViewCell)?.imagesViews {
            imageView.image = UIImage(named: imageName)
        } else if let imageView = (cell as? CollectionFPViewCell)?.imageFp {
            imageView.image = UIImage(named: imageName)
        } else if let imageView = (cell as? CollectionProductionViewCell)?.imageProduction {
            imageView.image = UIImage(named: imageName)
        }

        return cell
    }

}
