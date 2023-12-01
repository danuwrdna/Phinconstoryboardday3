import UIKit

class DetailProfileVC: UIViewController {
    var images: [DetailProfileModel] = []
    var image: UIImage?
 
    @IBOutlet weak var viewCollection: UICollectionView!
    @IBOutlet weak var imageButton: UIImageView!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        setupImageButton()
        passingData()
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    func passingData (){
        photoImage.image = image
    }
    
    func setupCollection(){
        images = DetailProfileModel.sampleData
        viewCollection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewCollection.delegate = self
        viewCollection.dataSource = self
        viewCollection.register(UINib(nibName: "DpViewCell", bundle: nil), forCellWithReuseIdentifier: "DpViewCell")
    }
    
    func setupImageButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backTapped))
        imageButton.isUserInteractionEnabled = true
        imageButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func backTapped() {
        print("Back button tapped!")
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
}

extension DetailProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DpViewCell", for: indexPath) as! DpViewCell
        cell.viewImages?.image = UIImage(named: images[indexPath.row].imageName)
        return cell
    }
}
