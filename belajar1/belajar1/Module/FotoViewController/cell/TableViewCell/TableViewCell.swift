import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageAutoCarousel: UIPageControl!
    @IBAction func lanjutButton(_ sender: Any) {
        setupAndNavigate()
    }
    @IBOutlet weak var lanjutButton: UIButton!
    var images = (1...3).compactMap{ namaFile in
        UIImage(named: "b\(namaFile)")}
    var timer: Timer?
    var currentIndex = 0
   
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
        pageAutoCarousel.numberOfPages = images.count
        startAutoSlide()
        print("ini file danu: \(images)")
    }
    func setupAndNavigate(){
        var responder: UIResponder? = self
            while responder != nil && !(responder is UIViewController) {
                responder = responder?.next
            }

            if let viewController = responder as? UIViewController {
                let lanjutButton = FaqViewController()
                viewController.navigationController?.pushViewController(lanjutButton, animated: true)
            }
    }
    
    func setupCollection(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
    }
    func startAutoSlide(){
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(autoSlide), userInfo: nil, repeats: true)
    }
    @objc func autoSlide(){
        let nextIndex = (currentIndex + 1) % images.count
        collectionView.scrollToItem(at: IndexPath(item: nextIndex,section: 0), at: .centeredHorizontally, animated: true)
        currentIndex = nextIndex
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 1000)
    }
    
    
    
    
}


