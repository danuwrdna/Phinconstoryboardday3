import UIKit
struct ModelDp{
    let imageName: String
    let height: CGFloat
}
class DetailProfileVC: UIViewController {
    var images: [ModelDp] = []
    @IBOutlet weak var viewCollection: UICollectionView!
    @IBOutlet weak var imageButton: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        setupImageButton()
        navigationItem.hidesBackButton = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    func setupCollection(){
        images = [
                   ModelDp(imageName: "vc1", height: 100),
                   ModelDp(imageName: "vc2", height: 100),
                   ModelDp(imageName: "vc3", height: 100),
                   ModelDp(imageName: "vc4", height: 100),
                  
               ]
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
            navigationController?.popViewController(animated: false)
        }
}
extension DetailProfileVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DpViewCell", for: indexPath) as! DpViewCell
        let data = [indexPath.row]
        cell.viewImages?.image = UIImage(named: images[indexPath.row].imageName)
        return cell
    }
}
